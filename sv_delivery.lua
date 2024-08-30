local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('delivery:complete', function(payment)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        -- Add payment
        Player.Functions.AddMoney("cash", payment)
    end
end)
