local start, removedpart, dropoffx, dropoffy, dropoffz, LicensePlate, vehicle, clientSideVeh = false, false, nil, nil,
    nil, nil, nil, nil

CurrentCops = 0

CreateThread(function()
    while start == false do
        Wait(200)
        while dropoffx or dropoffy or dropoffz ~= nil do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dis = #(pos - vector3(dropoffx, dropoffy, dropoffz))
            if dis <= 8 then
                if dis <= 8 and IsPedInAnyVehicle(ped) and start == false then
                    lib.showTextUI(Config.Locale["chop"], { position = "left-center" })
                    if IsControlJustPressed(0, 38) then
                        ScrapVehicle()
                        lib.hideTextUI()
                    end
                end
            end
            Wait(3)
        end
    end
end)

function SpawnVehicle(vehicle, x, y, z, w)
    local coords = vector4(x, y, z, w)
    local plate = nil

    SpawnVehicleCallback(vehicle, function(veh)
        SetEntityHeading(veh, coords.w)
        SetVehicleEngineOn(veh, false, false, true)
        SetVehicleOnGroundProperly(veh)
        SetVehicleNeedsToBeHotwired(veh, false)
        SetVehicleColours(vehicle, 0, 0)
        SetFuel(veh, 100.0)
        for i = 0, 5 do
            SetVehicleDoorShut(veh, i, true)
        end
        LicensePlate = GetVehicleNumberPlateText(veh)

        TriggerServerEvent("bd-chopshop:server:remove-lockpickable-vehicle", LicensePlate)

        plate = LicensePlate

        clientSideVeh = veh
    end, coords, true)

    while plate == nil do
        Wait(10)
    end

    return plate
end

RegisterNetEvent("bd-chopshop:client:remove-lockpickable-vehicle", function(LicensePlate)
    MakeVehicleNotLockpickable(LicensePlate)
    LicensePlate = LicensePlate
end)

function ScrapVehicle()
    local ped = PlayerPedId()
    vehicle = GetVehiclePedIsIn(ped, false)
    if GetVehicleNumberPlateText(vehicle) ~= LicensePlate then
        Notify(Config.Locale["WrongVeh"], 'error')
    else
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        local tableForOthers = StartChopping()
        print(vehicle)
        TriggerServerEvent("bd-chopshop:server:sync-scrapping", VehToNet(vehicle), tableForOthers)
    end
end

RegisterNetEvent("bd-chopshop:client:sync-scrapping", function(veh, tableForOthers)
    vehicle = NetToVeh(veh)
    print(vehicle)
    start = true
    Notify(Config.Locale["Reminder"], 8000)
    Config.CarTable = tableForOthers
    print(json.encode(Config.CarTable))
    DeleteBlip()
end)

RegisterNetEvent("bd-chopshop:client:update-chopped-part", function(index)
    Config.CarTable[index].chopped = true
end)

CreateThread(function()
    while true do
        Wait(7)
        if start then
            FreezeEntityPosition(vehicle, true)
            for k = 1, #Config.CarTable, 1 do
                if Config.CarTable[k].chopped == false and not IsPedInAnyVehicle(PlayerPedId()) then
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.CarTable[k].coords.x, Config.CarTable[k].coords.y, Config.CarTable[k].coords.z, true) < Config.CarTable[k].distance then
                        lib.showTextUI(Config.Locale["remove"] .. Config.CarTable[k].name, { position = "left-center" })
                        if (IsControlJustPressed(1, 38)) then
                            lib.hideTextUI()
                            StartAnimation(k)
                        end
                        if removedpart == false then
                            removedpart = true
                        end
                    end
                end
            end
            if GetVehiclePedIsIn(PlayerPedId()) == vehicle and removedpart == true then
                local pos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "windscreen"))
                lib.showTextUI(Config.Locale["destroy"], { position = "left-center" })
                if (IsControlJustPressed(1, 38)) then
                    local didDoProgress = ProgressBar(true, Config.Locale["crushing"], 6500, nil, nil)

                    if didDoProgress then
                        TaskLeaveVehicle(PlayerPedId(), vehicle, 1)
                        Wait(1500)
                        NetworkFadeOutEntity(vehicle, false, false)
                        Wait(1000)
                        DeleteEntity(vehicle)

                        TriggerServerEvent("bd-chopshop:server:end-job")

                        lib.hideTextUI()
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("bd-chopshop:client:player-too-far", function()
    VehicleToFar()
end)

function StartAnimation(k)
    if Config.CarTable[k].anim == "wheel1" or Config.CarTable[k].anim == "wheel2" or Config.CarTable[k].anim == "wheel3" or Config.CarTable[k].anim == "wheel4" then
        TriggerServerEvent("bd-chopshop:server:sync-chopping-item", Config.CarTable[k].anim, k)
        WheelAnimation()
        Wait(7400)
        if Config.CarTable[k].anim == "wheel1" then
            SetVehicleWheelXOffset(vehicle, 0, -2000)
            TriggerServerEvent('bd-chopshop:server:sync-wheel', 0, -2000)
        elseif Config.CarTable[k].anim == "wheel2" then
            SetVehicleWheelXOffset(vehicle, 2, -2000)
            TriggerServerEvent('bd-chopshop:server:sync-wheel', 2, -2000)
        elseif Config.CarTable[k].anim == "wheel3" then
            SetVehicleWheelXOffset(vehicle, 1, -2000)
            TriggerServerEvent('bd-chopshop:server:sync-wheel', 1, -2000)
        elseif Config.CarTable[k].anim == "wheel4" then
            SetVehicleWheelXOffset(vehicle, 3, -2000)
            TriggerServerEvent('bd-chopshop:server:sync-wheel', 3, -2000)
        end
        TriggerServerEvent('bd-chopshop:server:rewardplayer', Config.CarTable[k].anim)
    elseif Config.CarTable[k].anim == "door1" or Config.CarTable[k].anim == "door2" or Config.CarTable[k].anim == "door3" or Config.CarTable[k].anim == "door4" then
        TriggerServerEvent("bd-chopshop:server:sync-chopping-item", Config.CarTable[k].anim, k)
        TaskOpenVehicleDoor(PlayerPedId(), vehicle, 3000, Config.CarTable[k].getin, 10)
        Wait(2500)
        DoorAnimation()
        Wait(9000)
        SetVehicleDoorBroken(vehicle, Config.CarTable[k].destroy, true)
        TriggerServerEvent("bd-chopshop:server:sync-door", Config.CarTable[k].destroy)
        TriggerServerEvent('bd-chopshop:server:rewardplayer', Config.CarTable[k].anim)
    elseif Config.CarTable[k].anim == "trunk" then
        TriggerServerEvent("bd-chopshop:server:sync-chopping-item", Config.CarTable[k].anim .. "1", k)
        SetVehicleDoorOpen(vehicle, Config.CarTable[k].destroy, false, true)
        Wait(2500)
        TrunkAnimation()
        Wait(4000)
        TriggerServerEvent('bd-chopshop:server:rewardplayer', Config.CarTable[k].anim)
        Wait(9500)
        SetVehicleDoorBroken(vehicle, Config.CarTable[k].destroy, true)
        TriggerServerEvent("bd-chopshop:server:sync-door", Config.CarTable[k].destroy)
    elseif Config.CarTable[k].anim == "hood" then
        TriggerServerEvent("bd-chopshop:server:sync-chopping-item", Config.CarTable[k].anim .. "1", k)
        SetVehicleDoorOpen(vehicle, Config.CarTable[k].destroy, false, true)
        Wait(2500)
        HoodAnimation()
        Wait(9000)
        SetVehicleDoorBroken(vehicle, Config.CarTable[k].destroy, true)
        TriggerServerEvent("bd-chopshop:server:sync-door", Config.CarTable[k].destroy)
        TriggerServerEvent('bd-chopshop:server:rewardplayer', Config.CarTable[k].anim)
    end
end

RegisterNetEvent("bd-chopshop:client:sync-wheel", function(wheel, offset)
    SetVehicleWheelXOffset(vehicle, wheel, offset)
end)

RegisterNetEvent("bd-chopshop:client:sync-door", function(door)
    SetVehicleDoorBroken(vehicle, door, true)
end)

function VehicleToFar()
    DeleteEntity(vehicle)
    Reset()
    Notify(Config.Locale["FarAway"], 'error')
end

function CreateBlip(x, y)
    DeleteBlip()
    x = x + math.random(-75.0, 75.0)
    y = y + math.random(-75.0, 75.0)

    blip = AddBlipForRadius(x, y, 0.0, 200.0)
    SetBlipSprite(blip, 9)
    SetBlipColour(blip, 38)
    SetBlipAlpha(blip, 80)
end

function DeleteBlip()
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
    if DoesBlipExist(blip2) then
        RemoveBlip(blip2)
    end
end

function StartChopping()
    for i = 1, #Config.CarTable, 1 do
        local pos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, Config.CarTable[i].vehBone))
        Config.CarTable[i].coords = pos
    end
    for k = -1, 2, 1 do
        local pedseat = GetPedInVehicleSeat(vehicle, k)
        TaskLeaveVehicle(pedseat, vehicle, 1)
    end

    Wait(1000)

    return Config.CarTable
end

function StartChoppingOthers(BoneCoords)
    for i = 1, #Config.CarTable, 1 do
        Config.CarTable[i].coords = BoneCoords[i]
    end
end

function Reset()
    for i = 1, #Config.CarTable, 1 do
        Config.CarTable[i].chopped = false
    end
    secondwave = false
    vehicle = nil
    start = false
    removedpart = false

    DeleteBlip()

    TriggerEvent("bd-jobstatus:client:hide-job-stage")
    lib.hideTextUI()
end

lib.callback.register('bd-chopshop:client:can-start-job', function()
    if Config.Core.Framework == 'qb' then
        return CurrentCops >= Config.CopsNeeded
    elseif Config.Core.Framework == 'esx' then
        local cops = lib.callback.await('bd-chopshop:server:get-active-police-officers', false)
        return cops >= Config.CopsNeeded
    else
        return true
    end
end)

function SpawnDog(Coords)
    local current = "a_c_chop"
    local Ped = PlayerPedId()
    RequestModel(current)
    while not HasModelLoaded(current) do
        Wait(0)
    end
    kuchence = CreatePed("PED_TYPE_ANIMAL", current, Coords.x, Coords.y, Coords.z - 1, 90.0, true, true)
    NetworkRegisterEntityAsNetworked(kuchence)
    networkID = NetworkGetNetworkIdFromEntity(kuchence)
    SetNetworkIdCanMigrate(networkID, true)
    SetNetworkIdExistsOnAllMachines(networkID, true)
    SetPedRandomComponentVariation(kuchence)
    SetPedRandomProps(kuchence)
    SetEntityAsMissionEntity(kuchence)
    SetEntityVisible(kuchence, true)
    SetPedRelationshipGroupHash(kuchence)
    SetPedAccuracy(kuchence)
    SetPedArmour(kuchence)
    SetPedCanSwitchWeapon(kuchence, true)
    SetPedFleeAttributes(kuchence, false)
    TaskCombatPed(kuchence, Ped, 0, 16)
    SetPedCombatAttributes(kuchence, 46, true)
end

function HackKeyFob(data)
    if Config.EnableDog == true then
        SpawnDog(data['Coords'])
    end

    if Config.EnablePolice == true then
        ChopShopAlert()
    end

    local success = ChoppingMinigame()

    if success then
        TriggerServerEvent("bd-chopshop:server:hacked-keyfob", data)
    else
        Notify(Config.Locale["failedMinigame"], "error", 3000)

        NetworkFadeOutEntity(clientSideVeh, false, false)
        Wait(1000)
        DeleteEntity(clientSideVeh)

        TriggerServerEvent("bd-chopshop:server:end-job")
    end
end

lib.callback.register('bd-chopshop:client:spawn-vehicle', function(Job, GroupId)
    local Plate = SpawnVehicle(Job.Vehicle, Job.VehicleCoords.x, Job.VehicleCoords.y, Job.VehicleCoords.z,
        Job.VehicleCoords.w)

    return Plate
end)

RegisterNetEvent("bd-chopshop:client:enter-vehicle-zone", function(Job, GroupId, Plate)
    exports['bd-scanner']:SetupDigiScanner(vector3(Job.ScannerCoords.x, Job.ScannerCoords.y, Job.ScannerCoords.z), {
        event = HackKeyFob,
        isAction = true,
        args = { ['GroupId'] = tostring(GroupId), ['Plate'] = tostring(Plate), ['Coords'] = Job.DogCoords },
        interact = {
            interactKey = 38,
            interactMessage = Config.Locale["interactMessage"],
        }
    })
end)

function EnterVehicleZone(GroupId)
    TriggerServerEvent("bd-chopshop:server:enter-vehicle-zone", GroupId)
end

RegisterNetEvent("bd-chopshop:client:start-job", function(Job, GroupId)
    CreateBlip(Job.VehicleCoords.x, Job.VehicleCoords.y)

    chopZone = lib.zones.sphere({
        name = "ChopShopCarZone" .. GroupId,
        coords = vec3(Job.VehicleCoords.x, Job.VehicleCoords.y, Job.VehicleCoords.z),
        radius = 200,
        onEnter = function()
            EnterVehicleZone(GroupId)
        end
    })
end)

function EnterChopZone(GroupId)
    TriggerServerEvent("bd-chopshop:server:enter-chop-zone", GroupId)
end

RegisterNetEvent("bd-chopshop:client:chop-zone", function(Job, GroupId)
    RemoveBlip(blip)

    blip2 = AddBlipForCoord(Job.DeliveryCoords.x, Job.DeliveryCoords.y, Job.DeliveryCoords.z)
    SetBlipSprite(blip2, 225)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 1.0)
    SetBlipColour(blip2, 1)
    SetBlipAsShortRange(blip2, true)
    SetBlipRoute(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Chop Shop Area")
    EndTextCommandSetBlipName(blip2)

    chopZone = nil

    chopZone = lib.zones.sphere({
        name = "ChopShopCarZoneChopping" .. GroupId,
        coords = vec3(Job.DeliveryCoords.x, Job.DeliveryCoords.y, Job.DeliveryCoords.z),
        radius = 50,
        onEnter = function()
            EnterChopZone(GroupId)
        end
    })
end)

RegisterNetEvent("bd-chopshop:client:enter-chop-zone", function(Job, GroupId)
    dropoffx, dropoffy, dropoffz = Job.DeliveryCoords.x, Job.DeliveryCoords.y, Job.DeliveryCoords.z
end)

RegisterNetEvent("bd-chopshop:client:clear-everything", function()
    Reset()
    LicensePlate, dropoffx, dropoffy, dropoffz, dropoffm, randomVeh, randomCoords = nil
end)

CreateThread(function()
    AddTarget("chopshop", Config.JobData.ChopDownCoords, {
        {
            event = "bd-chopshop:StartMenu",
            label = Config.Locale["chopParts"],
            icon = "fas fa-hammer",
        },
    })
end)


local Items = {
    ["carpart_wheel"] = {
        hashKey = GetHashKey("imp_prop_impexp_tyre_01b"),
        bone = 60309,
        x = -0.05,
        y = 0.2,
        z = 0.35,
        rotX = -145.0,
        rotY = 100.0,
        rotZ = 0.0,
    },
    ["carpart_door"] = {
        hashKey = GetHashKey("imp_prop_impexp_car_door_04a"),
        bone = 60309,
        x = 0.16,
        y = -0.05,
        z = 0.5,
        rotX = -135.0,
        rotY = 180.0,
        rotZ = 0.0,
    },
    ["carpart_hood"] = {
        hashKey = GetHashKey("imp_prop_impexp_bonnet_02a"),
        bone = 60309,
        x = 0.58,
        y = 0.35,
        z = 0.24,
        rotX = -120.0,
        rotY = 115.0,
        rotZ = 0.0,
    },
    ["carpart_trunk"] = {
        hashKey = GetHashKey("imp_prop_impexp_trunk_01a"),
        bone = 60309,
        x = 0,
        y = -0.05,
        z = 0.3,
        rotX = -120.0,
        rotY = 115.0,
        rotZ = 0.0,
    },
}

local isDoingItemAnim = false
local ChopObject = nil
CreateThread(function()
    while true do
        if isDoingItemAnim == false then
            for k, v in pairs(Items) do
                if HasItem(k) then
                    isDoingItemAnim = k
                    break
                end
            end

            if ChopObject ~= nil then
                DeleteObject(ChopObject)
                ChopObject = nil
                StopAnimTask(ped, "anim@heists@box_carry@", "idle", 1.0)
            end
        else
            local ped = PlayerPedId()
            RequestAnimDict('anim@heists@box_carry@')
            while not HasAnimDictLoaded('anim@heists@box_carry@') do
                Wait(2)
            end

            if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
                TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                if ChopObject == nil then
                    ChopObject = CreateObject(Items[isDoingItemAnim].hashKey, 0, 0, 0, true, true, true)
                    AttachEntityToEntity(ChopObject, ped, GetPedBoneIndex(PlayerPedId(), Items[isDoingItemAnim].bone),
                        Items[isDoingItemAnim].x, Items[isDoingItemAnim].y, Items[isDoingItemAnim].z,
                        Items[isDoingItemAnim].rotX, Items[isDoingItemAnim].rotY, Items[isDoingItemAnim].rotZ, true, true,
                        false, true, 1, true)
                end
            end

            if not HasItem(isDoingItemAnim) then
                isDoingItemAnim = false
            end
        end
        Wait(200)
    end
end)

CreateThread(function()
    if Config.JobData.EnablePed then
        local pedModel = GetHashKey(Config.JobData.Ped)
        local pedCoords = Config.JobData.Coords

        lib.requestModel(pedModel)
        local pedId = CreatePed(4, pedModel, pedCoords.x, pedCoords.y, pedCoords.z - 1, pedCoords.w, false, true)
        SetEntityAsMissionEntity(pedId, true, true)
        SetBlockingOfNonTemporaryEvents(pedId, true)
        SetPedFleeAttributes(pedId, 0, 0)
        SetPedCombatAttributes(pedId, 17, true)
        SetPedSeeingRange(pedId, 0.0)
        SetPedHearingRange(pedId, 0.0)
        SetPedAlertness(pedId, 0)
        SetPedKeepTask(pedId, true)
        SetPedDropsWeaponsWhenDead(pedId, false)
        SetPedDiesWhenInjured(pedId, false)
        SetEntityInvincible(pedId, true)
        FreezeEntityPosition(pedId, true)

        AddTarget("pedId", pedCoords, {
            {
                label = Config.Locale["startJob"],
                icon = "fa-solid fa-gun",
                distance = 2,
                canInteract = function()
                    return not IsPedDeadOrDying(pedId)
                end,
                onSelect = function()
                    TriggerServerEvent("bd-chopshop:server:try-start-job")
                end,
            },
            {
                label = Config.Locale["accessShop"],
                icon = "fa-solid fa-store",
                distance = 2,
                canInteract = function()
                    return not IsPedDeadOrDying(pedId)
                end,
                onSelect = OpenChopShop,
            },
        })
    end
end)

function OpenChopShop()
    if Config.Core.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('shop', { type = 'chop-shop' })
    elseif Config.Core.Inventory == "qb-inventory" then
        TriggerServerEvent("bd-chopshop:server:open-chop-shop")
    elseif Config.Core.Inventory == "custom" then
        -- Add your custom inventory here
    else
        debugPrint("Inventory system not supported. Please use 'ox_inventory' or 'qb-inventory' or 'custom'")
    end
end
