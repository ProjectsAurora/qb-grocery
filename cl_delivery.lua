local QBCore = exports['qb-core']:GetCoreObject()

local deliveryBlip = nil
local inJob = false
local currentPayment = 0
local deliveryTargetId = nil

----- | SPAWNING A CIRCLE TARGET FOR DELIVERY START | -----
Citizen.CreateThread(function()
    -- Create a circle target for starting the delivery job
    for _, location in ipairs(Config.StartingPed.Locations) do
        local coords = location.coords
        exports['qb-target']:AddCircleZone("StartDelivery_" .. location.id, coords, 1.0, {
            name = "StartDelivery_" .. location.id,
            heading = location.heading or 0,
            debugPoly = false,
            minZ = location.minZ or coords.z - 1.0,
            maxZ = location.maxZ or coords.z + 1.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "delivery:client:StartDelivery",
                    icon = "fa-solid fa-box",
                    label = "Start Delivery",
                    job = Config.Jobname
                },
            },
            distance = 2.5,
        })
    end
end)

local function StartDeliveryJob()
    if inJob then
        QBCore.Functions.Notify("You already have a delivery job started.", "error")
        return
    end

    local delivery = Config.DeliveryJobs.Locations[math.random(#Config.DeliveryJobs.Locations)]
    local deliveryLocation = delivery.coords
    currentPayment = delivery.payment

    -- Create a blip for the delivery location
    deliveryBlip = AddBlipForCoord(deliveryLocation)
    SetBlipSprite(deliveryBlip, 280)
    SetBlipColour(deliveryBlip, 6)
    SetBlipAsShortRange(deliveryBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Delivery Location")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
    
    -- Create a circle target at the delivery location to finish the delivery
    if deliveryTargetId then
        exports['qb-target']:RemoveZone(deliveryTargetId)
    end

    deliveryTargetId = "FinishDelivery_" .. math.random(1000, 9999)
    exports['qb-target']:AddCircleZone(deliveryTargetId, deliveryLocation, 1.0, {
        name = deliveryTargetId,
        heading = 0,
        debugPoly = false,
        minZ = deliveryLocation.z - 1.0,
        maxZ = deliveryLocation.z + 1.0,
    }, {
        options = {
            {
                type = "client",
                event = "delivery:client:CompleteDelivery",
                icon = "fa-solid fa-box",
                label = "Complete Delivery",
                job = Config.Jobname
            },
        },
        distance = 2.5,
    })

    -- Notify the player
    QBCore.Functions.Notify("Delivery job started! Check your GPS for the location.", "success")
    inJob = true
end

local function CompleteDeliveryJob()
    if not inJob then
        QBCore.Functions.Notify("You don't have an active delivery job.", "error")
        return
    end

    -- Remove the blip
    if deliveryBlip then
        RemoveBlip(deliveryBlip)
    end

    -- Remove the circle target
    if deliveryTargetId then
        exports['qb-target']:RemoveZone(deliveryTargetId)
    end

    -- Notify the player
    QBCore.Functions.Notify("Delivery completed! You've been paid $" .. currentPayment, "success")

    -- Add payment
    TriggerServerEvent('delivery:complete', currentPayment)

    inJob = false
end

----- | EVENTS FOR TESTING | -----
RegisterNetEvent('delivery:client:StartDelivery', function()
    StartDeliveryJob()
end)

RegisterNetEvent('delivery:client:CompleteDelivery', function()
    CompleteDeliveryJob()
end)

----- | KEYBINDINGS FOR TESTING | -----
RegisterCommand('startdelivery', function()
    StartDeliveryJob()
end, false)

RegisterCommand('completedelivery', function()
    CompleteDeliveryJob()
end, false)
