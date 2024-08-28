-- Ensure QBCore is correctly initialized
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('shop:getShopItems')
AddEventHandler('shop:getShopItems', function(shopId)
    local src = source
    local shop = Config.Shops[shopId]
    if shop then
        TriggerClientEvent('shop:showShopMenu', src, shop)
    end
end)

RegisterNetEvent('shop:purchaseItem')
AddEventHandler('shop:purchaseItem', function(itemName, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    -- Check if player has enough money
    if Player.PlayerData.money.cash >= itemPrice then
        Player.Functions.RemoveMoney('cash', itemPrice)
        -- Add the item to the player's inventory
        Player.Functions.AddItem(itemName, 1)
        TriggerClientEvent('QBCore:Notify', src, "Purchase successful!", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough money!", "error")
    end
end)
