if Config["Core"]["Framework"] ~= "esx" then return end

debugPrint("Chop Shop:ESX:Loading ESX")

OnJobUpdateEvent = "esx:setJob"

PlayerData = {}

Framework = exports["es_extended"]:getSharedObject()

CreateThread(function()
    local PlayerData = Framework.GetPlayerData()
    while PlayerData == nil do
        Wait(100)
    end
end)

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    while xPlayer == nil do
        Wait(1000)
    end
    PlayerData = xPlayer
    Framework.PlayerLoaded = true
end)

while not Framework.PlayerLoaded do
    Wait(500)
end

RegisterNetEvent("esx:onPlayerLogout", function()
    PlayerData = nil
end)

RegisterNetEvent("esx:setJob", function(job)
    PlayerData.job = job
end)

debugPrint("Chop Shop:ESX:ESX loaded")

function Notify(message, type, time)
    TriggerEvent("esx:showNotification", message, type, time)
end
