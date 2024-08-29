local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('shop:getShopItems', function(source, cb, shopId)
    local shop = Config.Shops[shopId]
    if shop then
        cb(shop)
    else
        TriggerClientEvent('QBCore:Notify', source, "Shop not found!", "error")
        cb(nil)
    end
end)

RegisterServerEvent('shop:purchaseItem')
AddEventHandler('shop:purchaseItem', function(itemName, itemPrice, shopId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local shop = Config.Shops[shopId]

    if shop then
        local item = nil
        for _, i in pairs(shop.items) do
            if i.name == itemName then
                item = i
                break
            end
        end

        if item and item.stock > 0 then
            if player.Functions.RemoveMoney('cash', itemPrice) then
                player.Functions.AddItem(item.name, 1)
                item.stock = item.stock - 1
                TriggerClientEvent('QBCore:Notify', src, "Item purchased!", "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "Not enough money!", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Item out of stock!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Shop not found!", "error")
    end
end)
