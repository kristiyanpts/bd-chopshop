if Config["Core"]["Framework"] ~= 'qb' then return end

debugPrint("Chop Shop:QB:Loading Framework")

Framework = exports['qb-core']:GetCoreObject()

PlayerData = {}
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobInfo)
    PlayerData.job = jobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBPlayerData = Framework.Functions.GetPlayerData()

    PlayerData = {
        identifier = QBPlayerData.citizenid,
        job = QBPlayerData.job
    }
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData.identifier = nil
    PlayerData.job = nil
end)

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

debugPrint("Chop Shop:QB:Framework loaded")

local QBPlayerData = Framework.Functions.GetPlayerData()

PlayerData = {
    identifier = QBPlayerData.citizenid,
    job = QBPlayerData.job,
    money = QBPlayerData.money
}

function Notify(message, type, time)
    TriggerEvent("QBCore:Notify", message, type, time)
end
