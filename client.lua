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
                    event = "shop:purchaseItem",
                    args = {
                        itemName = item.name,
                        itemPrice = item.price,
                        shopId = shop.shopName
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

RegisterNetEvent('shop:purchaseItem')
AddEventHandler('shop:purchaseItem', function(data)
    TriggerServerEvent('shop:purchaseItem', data.itemName, data.itemPrice, data.shopId)
end)
