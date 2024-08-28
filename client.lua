local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    for k, shop in pairs(Config.Shops) do
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
                    icon = "fas fa-store", -- Target icon
                    label = shop.targetLabel,
                    shopId = k
                }
            },
            distance = 2.5
        })
    end
end)

RegisterNetEvent('shop:openShop')
AddEventHandler('shop:openShop', function(data)
    TriggerServerEvent('shop:getShopItems', data.shopId)
end)

RegisterNetEvent('shop:showShopMenu')
AddEventHandler('shop:showShopMenu', function(shop)
    local elements = {}
    for _, item in pairs(shop.items) do
        table.insert(elements, {
            header = item.name .. " - $" .. item.price,
            txt = "Purchase " .. item.name .. " for $" .. item.price,
            icon = "fas fa-shopping-cart", -- Single icon for all menu items
            params = {
                event = "shop:purchaseItem",
                args = {
                    itemName = item.name,
                    itemPrice = item.price
                }
            }
        })
    end

    -- Use qb-menu to display the shop items
    exports['qb-menu']:openMenu(elements)
end)

RegisterNetEvent('shop:purchaseItem')
AddEventHandler('shop:purchaseItem', function(data)
    local itemName = data.itemName
    local itemPrice = data.itemPrice
    TriggerServerEvent('shop:purchaseItem', itemName, itemPrice)
end)
