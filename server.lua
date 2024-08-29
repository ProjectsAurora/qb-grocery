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
AddEventHandler('shop:purchaseItem', function(itemName, itemPrice, quantity, shopId)
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

        if item and item.stock >= quantity then
            local totalPrice = itemPrice * quantity
            if player.Functions.RemoveMoney('cash', totalPrice) then
                player.Functions.AddItem(item.name, quantity)
                item.stock = item.stock - quantity
                TriggerClientEvent('QBCore:Notify', src, "Item purchased!", "success")
            else
                TriggerClientEvent('QBCore:Notify', src, "Not enough money!", "error")
            end
        elseif item and item.stock < quantity then
            TriggerClientEvent('QBCore:Notify', src, "Not enough stock!", "error")
        else
            TriggerClientEvent('QBCore:Notify', src, "Item not found!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Shop not found!", "error")
    end
end)
