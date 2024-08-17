if Config["Core"]["Framework"] ~= 'esx' then return end

Framework = exports["es_extended"]:getSharedObject()

-- * Gets the identifier of a player's character.
function GetPlayerIdentifier(source)
    local xPlayer = Framework.GetPlayerFromId(source)
    if xPlayer ~= nil then
        return xPlayer.identifier
    end
    return
end

-- * Gets the source of a player's character.
function GetPlayerSourceFromIdentifier(ident)
    local xPlayer = Framework.GetPlayerFromIdentifier(ident)
    if xPlayer ~= nil then
        return xPlayer.source
    end
    return
end

-- * Gets the bank balance of a player.
function GetBankBalance(source)
    local xPlayer = Framework.GetPlayerFromId(source)
    if xPlayer == nil then
        return 0
    end

    return xPlayer.getAccount("bank")?.money or 0
end

-- * Adds money to a player's bank account.
function AddMoney(source, account, amount)
    local xPlayer = Framework.GetPlayerFromId(source)
    if xPlayer == nil or amount < 0 then
        return false
    end

    xPlayer.addAccountMoney(account, amount)
    return true
end

-- * Removes money from a player's bank account.
function RemoveMoney(source, account, amount)
    local xPlayer = Framework.GetPlayerFromId(source)
    if xPlayer == nil or amount < 0 or GetBankBalance(source) < amount then
        return false
    end

    xPlayer.removeAccountMoney(account, amount)

    return true
end

-- * Sends a notification to a player.
function Notify(source, message, type, time)
    TriggerClientEvent("esx:showNotification", source, message, type, time)
end

-- * Gets the job of a player.
function GetJob(source)
    local xPlayer = Framework.GetPlayerFromId(source)
    return xPlayer.job?.name
end
