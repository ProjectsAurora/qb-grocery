local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
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

    -- Adding Blip
    local blip = AddBlipForCoord(Config.Blip.coords)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
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
                        maxAmount = item.stock -- Pass the maximum stock available
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
