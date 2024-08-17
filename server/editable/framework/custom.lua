if Config["Core"]["Framework"] ~= 'custom' then return end

-- * Gets the license of a the player.
function GetPlayerIdentifier(source)
    for _, v in pairs(GetPlayerIdentifiers(source)) do
        if v:sub(1, #"license:") == "license:" then
            return v
        end
    end
end

-- * Gets the bank balance of a player.
function GetBankBalance(source)
    return 0
end

-- * Adds money to a player's bank account.
function AddMoney(source, amount)
    return true
end

-- * Removes money from a player's bank account.
function RemoveMoney(source, amount)
    return true
end

-- * Sends a notification to a player.
function Notify(source, message, type, time)
    TriggerClientEvent("chat:addMessage", source, {
        color = { 255, 255, 255 },
        multiline = true,
        args = { "Computer", message }
    })
end

-- * Get the job of a player.
function GetJob(source)
    return "unemployed"
end
