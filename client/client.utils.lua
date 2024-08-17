function ChopShopAlert()
    -- PUT YOUR DISPATCH ALERT HERE
    -- exports["sp-dispatch"]:StoreRobbery()
end

-- Progressbar function
function ProgressBar(waitForResult, text, time, animDict, anim)
    local result = nil
    if Config.Core.ProgressBar == "qb" then
        Framework.Functions.Progressbar('chopshop', text, time,
            false,
            true, { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = animDict,
                anim = anim
            }, {}, {}, function()
                result = true

                ClearPedTasks(PlayerPedId())
            end, function()
                result = false

                ClearPedTasks(PlayerPedId())
            end)
    elseif Config.Core.ProgressBar == "ox" then
        if lib.progressBar({
                duration = time,
                label = text,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    mouse = true,
                    combat = true,
                    sprint = true,
                },
                anim = {
                    dict = animDict,
                    clip = anim
                }
            }) then
            result = true

            ClearPedTasks(PlayerPedId())
        else
            result = false

            ClearPedTasks(PlayerPedId())
        end
    end

    if waitForResult == true then
        while result == nil do
            Wait(0)
        end

        return result
    else
        return result
    end
end

if Config.Core.Framework == "qb" then
    RegisterNetEvent('police:SetCopCount')
    AddEventHandler('police:SetCopCount', function(Amount)
        CurrentCops = Amount
    end)
end

-- Target function
function AddTarget(id, pos, options)
    if Config.Core.Target == "qb" then
        local sizex = 0.5
        local sizey = 0.5

        for k, v in pairs(options) do
            if v.serverEvent then
                v.event = v.serverEvent
                v.type = "server"
            else
                v.type = "client"
            end

            if v.onSelect then
                v.action = v.onSelect
            end
        end

        exports["qb-target"]:AddBoxZone(id, pos, sizex, sizey, {
            name = id,
            heading = 90.0,
            minZ = pos.z - 5,
            maxZ = pos.z + 5
        }, {
            options = options,
            distance = 2,
        })

        return id
    end
    if Config.Core.Target == "ox" then
        return exports["ox_target"]:addBoxZone({ -- -1183.28, -884.06, 13.75
            coords = vec3(pos.x, pos.y, pos.z),
            size = vec3(0.5, 0.5, 2),
            rotation = 45,
            debug = false,
            options = options
        })
    end
end

function RemoveTarget(sendid)
    if Config.Core.Target == "qb" then
        exports["qb-target"]:RemoveZone(sendid)
    end
    if Config.Core.Target == "ox" then
        exports["ox_target"]:removeZone(sendid)
    end
    return true
end

function ChoppingMinigame()
    return exports['bd-minigames']:Chopping(6, 7)
end

-- Fuel function
function SetFuel(vehicle, fuel)
    if Config.Core.Fuel == "cdn-fuel" or Config.Core.Fuel == "LegacyFuel" then
        exports[Config.Core.Fuel]:SetFuel(vehicle, fuel)
    elseif Config.Core.Fuel == "custom" then
        -- Your custom export
    else
        debugPrint("Fuel system provided in config is not supported. Please use 'cdn-fuel' or 'LegacyFuel' or 'custom'")
    end
end

-- Vehiclekeys function
function MakeVehicleNotLockpickable(plate)
    if Config.Core.VehicleKeys == "qb" then
        exports["qb-vehiclekeys"]:MakeVehicleNotLockpickable(plate)
    elseif Config.Core.VehicleKeys == "custom" then
        -- Your custom export
    else
        debugPrint("Vehicle keys system provided in config is not supported. Please use 'qb' or 'custom'")
    end
end

RegisterNetEvent("bd-chopshop:client:add-vehicle-keys", function(plate)
    if Config.Core.VehicleKeys == "qb" then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    elseif Config.Core.VehicleKeys == "custom" then
        -- Your custom export
    else
        debugPrint("Vehicle keys system provided in config is not supported. Please use 'qb' or 'custom'")
    end
end)

function SpawnVehicleCallback(model, cb, coords, isnetworked, teleportInto)
    local ped = PlayerPedId()
    model = type(model) == 'string' and GetHashKey(model) or model
    if not IsModelInCdimage(model) then return end
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    isnetworked = isnetworked == nil or isnetworked
    lib.requestModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, isnetworked, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetNetworkIdCanMigrate(netid, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, 'OFF')
    SetVehicleFuelLevel(veh, 100.0)
    SetModelAsNoLongerNeeded(model)
    if teleportInto then TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1) end
    if cb then cb(veh) end
end
