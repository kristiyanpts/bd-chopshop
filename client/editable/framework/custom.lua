if Config["Core"]["Framework"] ~= 'custom' then return end

debugPrint("Chop Shop:Custom:Loading Framework")

-- Export for your framework
Framework = true

RegisterNetEvent('your-job-update-event', function(jobInfo)
    PlayerData.job = jobInfo
end)

RegisterNetEvent('your-player-loaded-event', function()
    -- Get player data
    CustomPlayerData = {}

    PlayerData = {
        identifier = CustomPlayerData.citizenid,
        job = CustomPlayerData.job
    }
end)

RegisterNetEvent('your-player-unloaded-event', function()
    PlayerData.identifier = nil
    PlayerData.job = nil
end)

while not LocalPlayer.state.isLoggedIn do
    Wait(500)
end

debugPrint("Chop Shop:Custom:Framework loaded")

-- Get player data
local CustomPlayerData = {}

PlayerData = {
    identifier = CustomPlayerData.citizenid,
    job = CustomPlayerData.job,
    money = CustomPlayerData.money
}

function Notify(message, type, time)
    TriggerEvent("your-notify-event", message, type, time)

    -- or export I guess :D
end
