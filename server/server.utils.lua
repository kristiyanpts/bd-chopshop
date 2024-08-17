if Config.Core.Framework == "esx" then
    lib.callback.register('bd-chopshop:server:get-active-police-officers', function(source)
        local xPlayers = Framework.GetPlayers()
        local policeCount = 0

        for i = 1, #xPlayers, 1 do
            local xPlayer = Framework.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                policeCount = policeCount + 1
            end
        end

        return policeCount
    end)
end
