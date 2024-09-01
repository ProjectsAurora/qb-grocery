local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    -- Check if Config is defined
    if not Config then
        print("Error: Config is not loaded.")
        return
    end

    -- Add shop targets
    for shopName, shop in pairs(Config.Shops) do
        exports['qb-target']:AddBoxZone(shop.shopName, shop.coords, shop.boxZone[1], shop.boxZone[2], {
            name = shop.shopName,
            heading = shop.heading,
            debugPoly = false,
            minZ = shop.minZ,
            maxZ = shop.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "shop:openShop",
                    icon = "fas fa-store",
                    label = shop.targetLabel,
                    shopId = shopName
                }
            },
            distance = 2.5
        })
    end

    -- Add Blip
    local blip = AddBlipForCoord(Config.Blip.coords)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipDisplay(blip, 8)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.name)
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('shop:openShop')
AddEventHandler('shop:openShop', function(data)
    QBCore.Functions.TriggerCallback('shop:getShopItems', function(shop)
        if shop then
            TriggerEvent('shop:showShopMenu', shop)
        else
            TriggerEvent('QBCore:Notify', "Shop not found!", "error")
        end
    end, data.shopId)
end)

RegisterNetEvent('shop:showShopMenu')
AddEventHandler('shop:showShopMenu', function(shop)
    local elements = {}
    for _, item in pairs(shop.items) do
        if item.stock > 0 then
            table.insert(elements, {
                header = item.label .. " - $" .. item.price .. " [Stock: " .. item.stock .. "]",
                txt = "Purchase " .. item.label .. " for $" .. item.price,
                icon = "fas fa-shopping-cart",
                params = {
                    event = "shop:requestPurchaseQuantity",
                    args = {
                        itemName = item.name,
                        itemPrice = item.price,
                        shopId = shop.shopName,
                        maxAmount = item.stock
                    }
                }
            })
        else
            table.insert(elements, {
                header = item.label .. " [Out of Stock]",
                txt = "This item is currently out of stock.",
                icon = "fas fa-shopping-cart",
                isMenuHeader = true
            })
        end
    end

    exports['qb-menu']:openMenu(elements)
end)

RegisterNetEvent('shop:requestPurchaseQuantity')
AddEventHandler('shop:requestPurchaseQuantity', function(data)
    local sellingItem = exports['qb-input']:ShowInput({
        header = 'Enter Quantity',
        submitText = 'Purchase',
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Max: ' .. data.maxAmount
            }
        }
    })

    if sellingItem then
        local quantity = tonumber(sellingItem.amount)
        if quantity and quantity > 0 and quantity <= data.maxAmount then
            TriggerServerEvent('shop:purchaseItem', data.itemName, data.itemPrice, quantity, data.shopId)
        else
            TriggerEvent('QBCore:Notify', "Invalid quantity entered. Please enter a number between 1 and " .. data.maxAmount .. ".", "error")
        end
    else
        TriggerEvent('QBCore:Notify', "No quantity entered.", "error")
    end
end)

Citizen.CreateThread(function()
    if Config and Config.RestockLocation then
        exports['qb-target']:AddBoxZone("RestockLocation", Config.RestockLocation.coords, Config.RestockLocation.size.x, Config.RestockLocation.size.y, {
            name = "RestockLocation",
            heading = Config.RestockLocation.heading,
            debugPoly = false,
            minZ = Config.RestockLocation.minZ,
            maxZ = Config.RestockLocation.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "restock:openRestockMenu",
                    icon = "fas fa-box",
                    label = "Restock",
                    job = "grocery"  -- Ensure this matches your job name exactly
                }
            },
            distance = 2.5
        })
    else
        print("Error: Config or Config.RestockLocation is nil.")
    end
end)


RegisterNetEvent('restock:openRestockMenu')
AddEventHandler('restock:openRestockMenu', function()
    QBCore.Functions.GetPlayerData(function(data)
        if data.job.name == Config.Jobname then
            local restockCost = Config.Restock.cost

            local menuOptions = {
                {
                    header = "Confirm Restock",
                    icon = "fas fa-money-bill-wave",
                    txt = "Restock will cost $" .. restockCost,
                    params = {
                        event = "restock:confirmRestock",
                        args = {
                            cost = restockCost
                        }
                    }
                },
                {
                    header = "Cancel",
                    txt = "Cancel the restock operation",
                    icon = "fas fa-times",
                    params = {
                        event = "restock:cancelRestock"
                    }
                }
            }

            exports['qb-menu']:openMenu(menuOptions)
        else
            TriggerEvent('QBCore:Notify', "You are not authorized to restock.", "error")
        end
    end)
end)

RegisterNetEvent('restock:confirmRestock')
AddEventHandler('restock:confirmRestock', function(data)
    local restockCost = data.cost
    TriggerServerEvent('restock:attemptRestock', restockCost)
end)

RegisterNetEvent('restock:cancelRestock')
AddEventHandler('restock:cancelRestock', function()
    TriggerEvent('QBCore:Notify', "Restock cancelled.", "info")
end)

---- Storage For Job 

Citizen.CreateThread(function()
    if Config and Config.StorageLocation then
        exports['qb-target']:AddBoxZone(Config.StorageLocation.name, Config.StorageLocation.coords, Config.StorageLocation.size.x, Config.StorageLocation.size.y, {
            name = Config.StorageLocation.name,
            heading = Config.StorageLocation.heading,
            debugPoly = false,
            minZ = Config.StorageLocation.minZ,
            maxZ = Config.StorageLocation.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-grocery:client:bjobFridge",
                    icon = "fa-solid fa-box",
                    label = "Storage",
                    job = "grocery",  -- Ensure this matches your job name exactly
                }
            },
            distance = 2.5
        })
    else
        print("Error: Config or Config.StorageLocation is nil.")
    end
end)

RegisterNetEvent("qb-grocery:client:bjobFridge")
AddEventHandler("qb-grocery:client:bjobFridge", function()
    TriggerServerEvent('qb-grocery:server:bjobFridge')
end)

----- | SETTING THE CLOCK IN/OUT TARGET | -----
exports['qb-target']:AddBoxZone("GroceryClock", vector3(-1119.49, -1351.53, 5.04), 1.0, 1.0, {
    name = "GroceryClock",
    heading = 347.27,
    debugPoly = false,
    minZ = 05.04 - 2,
    maxZ = 06.38 + 2,
}, {
    options = {
        {
            type = "client",
            event = "qb-grocery:client:ToggleDuty",
            icon = "fa-solid fa-clipboard-user",
            label = "Clock In/Out",
            job = "grocery",
        },
        {
            type = "client",
            event = "qb-bossmenu:client:OpenMenu",
            icon = "fa-solid fa-right-to-bracket",
            label = "Boss Menu",
            job = {["grocery"] = 4},
        },
    },
    distance = 2.5
})

----- | REGISTERING THE EVENT TO TOGGLE DUTY ON/OFF | -----
RegisterNetEvent('qb-grocery:client:ToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)



