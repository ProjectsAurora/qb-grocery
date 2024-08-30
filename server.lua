local QBCore = exports['qb-core']:GetCoreObject()

-- Callback to get shop items
QBCore.Functions.CreateCallback('shop:getShopItems', function(source, cb, shopId)
    local shop = Config.Shops[shopId]
    cb(shop or nil)
end)

-- Event to handle item purchases
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

        if item then
            if item.stock >= quantity then
                local totalPrice = itemPrice * quantity
                if player.Functions.RemoveMoney('cash', totalPrice) then
                    player.Functions.AddItem(item.name, quantity)
                    item.stock = item.stock - quantity
                    TriggerClientEvent('QBCore:Notify', src, "Item purchased!", "success")
                    TriggerClientEvent('shop:updateShopMenu', src, shopId)
                else
                    TriggerClientEvent('QBCore:Notify', src, "Not enough money!", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Not enough stock!", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Item not found!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Shop not found!", "error")
    end
end)

-- Event to handle restock at specific location
RegisterServerEvent('restock:restockAtLocation')
AddEventHandler('restock:restockAtLocation', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if player and player.PlayerData.job.name == "grocery" then
        for shopId, shop in pairs(Config.Shops) do
            for _, item in pairs(shop.items) do
                item.stock = Config.Restock.maxStock
            end
        end

        TriggerClientEvent('QBCore:Notify', src, "Store has been restocked!", "success")
        TriggerClientEvent('shop:updateShopMenu', -1, "all")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have permission to restock this store.", "error")
    end
end)

-- Periodic restock timer
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Restock.timer * 1000)
        for shopId, shop in pairs(Config.Shops) do
            for _, item in pairs(shop.items) do
                item.stock = Config.Restock.maxStock
            end
            TriggerClientEvent('shop:updateShopMenu', -1, shopId)
        end
    end
end)

-- Event to open fridge inventory
RegisterNetEvent('qb-grocery:server:bjobFridge', function(bjobFridge)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Burger Fridge'

    if Player then
        exports['ps-inventory']:OpenInventory(src, stashName, {
            maxweight = 750000,
            slots = 50,
        })
    end
end)

-- Event to handle restock attempt with cost
RegisterServerEvent('restock:attemptRestock')
AddEventHandler('restock:attemptRestock', function(restockCost)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player and player.PlayerData.job.name == Config.Jobname then
        local currentCash = player.Functions.GetMoney('cash')

        if currentCash >= restockCost then
            player.Functions.RemoveMoney('cash', restockCost)

            for shopId, shop in pairs(Config.Shops) do
                for _, item in pairs(shop.items) do
                    item.stock = Config.Restock.maxStock
                end
            end

            TriggerClientEvent('QBCore:Notify', src, "Store has been restocked!", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Not enough money to restock!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have permission to restock this store.", "error")
    end
end)
