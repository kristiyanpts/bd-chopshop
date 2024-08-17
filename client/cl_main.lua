-- New Core and Old Core stuff
if Config.Version == "new" then

    QBCore = exports['qb-core']:GetCoreObject()

end

local PlayerJob = {}
local secondwave = false
local vehicle
local start = false
local removedpart = false

local dropoffx = nil
local dropoffy = nil
local dropoffz = nil
local dropoffm = nil

local LicensePlate = nil
local randomLoc = nil
local vehicle = nil
local copsCalled = false
local cooldown = false
local scrapblip = false
local clientSideVeh = nil

local chopZone = nil 

local CurrentCops = 0

-- Job Update and checks
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

CreateThread(function()
    Wait(500)
    if QBCore.Functions.GetPlayerData() ~= nil then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        onDuty = true
    end
end)

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

function SpawnVehicle(vehicle, x ,y, z, w)
    local coords = vector4(x, y, z, w)
    local plate = nil

    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetEntityHeading(veh, coords.w)
        SetVehicleEngineOn(veh, false, false)
        SetVehicleOnGroundProperly(veh)
        SetVehicleNeedsToBeHotwired(veh, false)
		SetVehicleColours(vehicle, 0, 0)
        exports['cdn-fuel']:SetFuel(veh, 100.0)
        for i = 0, 5 do
            SetVehicleDoorShut(veh, i, true)
        end
        LicensePlate = GetVehicleNumberPlateText(veh)

        TriggerServerEvent("sp-chopshop:server:remove-lockpickable-vehicle", LicensePlate)

        plate = LicensePlate

        clientSideVeh = veh
    end, coords, true)

    while plate == nil do
        Wait(10)
    end

    return plate
end

RegisterNetEvent("sp-chopshop:client:remove-lockpickable-vehicle", function(LicensePlate)
    exports["qb-vehiclekeys"]:MakeVehicleNotLockpickable(LicensePlate)
    LicensePlate = LicensePlate
end)

function ScrapVehicle()
	local ped = PlayerPedId()
	vehicle = GetVehiclePedIsIn(ped, false)
    if GetVehicleNumberPlateText(vehicle) ~= LicensePlate then
        QBCore.Functions.Notify(Config.Locale["WrongVeh"], 'error')
	else 
		local netId = NetworkGetNetworkIdFromEntity(vehicle)
        local tableForOthers = StartChopping()
        TriggerServerEvent("sp-chopshop:server:sync-scrapping", vehicle, tableForOthers)
    end
end

RegisterNetEvent("sp-chopshop:client:sync-scrapping", function(veh, tableForOthers)
    vehicle = veh
	start = true
    QBCore.Functions.Notify(Config.Locale["Reminder"], 8000)
    Config.CarTable = tableForOthers
    print(json.encode(Config.CarTable))
    DeleteBlip()
end)

RegisterNetEvent("sp-chopshop:client:update-chopped-part", function(index)
    Config.CarTable[index].chopped = true
end)

CreateThread(function()
	while true do
		Wait(7)
		if start then
			FreezeEntityPosition(vehicle, true)
            for k=1, #Config.CarTable, 1 do
                if Config.CarTable[k].chopped == false and not IsPedInAnyVehicle(PlayerPedId())   then
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.CarTable[k].coords.x, Config.CarTable[k].coords.y, Config.CarTable[k].coords.z, true ) < Config.CarTable[k].distance then
                        lib.showTextUI(Config.Locale["remove"]..Config.CarTable[k].name, { position = "left-center" })
                        if(IsControlJustPressed(1, 38)) then
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
                if(IsControlJustPressed(1, 38))  then
                    QBCore.Functions.Progressbar("crushing", Config.Locale["crushing"], (6500), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        TaskLeaveVehicle(PlayerPedId(), vehicle, 1)
                        Wait(1500)
                        NetworkFadeOutEntity(vehicle,false,false)
                        Wait(1000)
                        DeleteEntity(vehicle)

                        TriggerServerEvent("sp-chopshop:server:end-job")

                        lib.hideTextUI()
                    end)
				end
			end
			-- if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),dropoffx, dropoffy, dropoffz,true) > 50 and start == true  then
            --     TriggerServerEvent("sp-chopshop:server:end-job")
            --     return
			-- end
		end
	end
end)

RegisterNetEvent("sp-chopshop:client:player-too-far", function()
    VehicleToFar()
end)

function StartAnimation(k)
	if Config.CarTable[k].anim == "wheel1" or Config.CarTable[k].anim == "wheel2" or Config.CarTable[k].anim == "wheel3" or Config.CarTable[k].anim == "wheel4" then
        TriggerServerEvent("sp-chopshop:server:sync-chopping-item", Config.CarTable[k].anim, k)
		TriggerEvent('sp-chopshop:wheelanimation', Config.CarTable[k].anim)
		Wait(7400)
		if Config.CarTable[k].anim == "wheel1" then
			SetVehicleWheelXOffset(vehicle, 0, -2000)
		elseif Config.CarTable[k].anim == "wheel2" then
			SetVehicleWheelXOffset(vehicle, 2, -2000)
		elseif Config.CarTable[k].anim == "wheel3" then
			SetVehicleWheelXOffset(vehicle, 1, -2000)
		elseif Config.CarTable[k].anim == "wheel4" then 
			SetVehicleWheelXOffset(vehicle, 3, -2000)
		end
		TriggerServerEvent('sp-chopshop:server:rewardplayer', Config.CarTable[k].anim)	
	elseif Config.CarTable[k].anim == "door1" or Config.CarTable[k].anim == "door2" or Config.CarTable[k].anim == "door3" or Config.CarTable[k].anim == "door4" then
        TriggerServerEvent("sp-chopshop:server:sync-chopping-item", Config.CarTable[k].anim, k)
		TaskOpenVehicleDoor(PlayerPedId(),vehicle,3000,Config.CarTable[k].getin,10)
		Wait(2500)  
		TriggerEvent('sp-chopshop:dooranimation')
		Wait(9000)
		SetVehicleDoorBroken(vehicle,Config.CarTable[k].destroy,true)
		TriggerServerEvent('sp-chopshop:server:rewardplayer', Config.CarTable[k].anim)
	elseif Config.CarTable[k].anim == "trunk"  then
        TriggerServerEvent("sp-chopshop:server:sync-chopping-item", Config.CarTable[k].anim .. "1", k)
		SetVehicleDoorOpen(vehicle, Config.CarTable[k].destroy, false, true)
		Wait(2500)  
		TriggerEvent('sp-chopshop:trunkanimation')
		Wait(4000)
		TriggerServerEvent('sp-chopshop:server:rewardplayer', Config.CarTable[k].anim)
		Wait(9500)
		SetVehicleDoorBroken(vehicle,Config.CarTable[k].destroy,true)
	elseif Config.CarTable[k].anim == "hood" then
        TriggerServerEvent("sp-chopshop:server:sync-chopping-item", Config.CarTable[k].anim .. "1", k)
		SetVehicleDoorOpen(vehicle, Config.CarTable[k].destroy, false, true)
		Wait(2500)  
		TriggerEvent('sp-chopshop:hoodanimation')
		Wait(9000)
		SetVehicleDoorBroken(vehicle,Config.CarTable[k].destroy,true)
		TriggerServerEvent('sp-chopshop:server:rewardplayer', Config.CarTable[k].anim)
	end
end

function VehicleToFar() 
	DeleteEntity(vehicle)
	Reset()
	QBCore.Functions.Notify(Config.Locale["FarAway"], 'error')
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
        Config.CarTable[i].coords=pos
    end
    for k = -1, 2, 1 do
        local pedseat = GetPedInVehicleSeat(vehicle,k)
        TaskLeaveVehicle(pedseat, vehicle, 1)
	end

    Wait(1000)

    return Config.CarTable
end

function StartChoppingOthers(BoneCoords)
    for i = 1, #Config.CarTable, 1 do
        Config.CarTable[i].coords=BoneCoords[i]
    end
end

function Reset()
	for i=1, #Config.CarTable, 1 do
		Config.CarTable[i].chopped=false
	end
	secondwave = false
	vehicle = nil
	start = false
	removedpart = false

    DeleteBlip()

    TriggerEvent("sp-laptop:client:hide-job-stage")
    lib.hideTextUI()
end

lib.callback.register('sp-choshop:client:can-start-job', function()
    return exports["sp-blackmarket-encrypted"]:CanPlayerInteract("isCrime", false) and CurrentCops >= Config.CopsNeeded
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
        exports['sp-dispatch']:ChopShop()
    end

    local success = exports['sp-minigame']:MemoryCards('hard', 2)

    if success then
        TriggerServerEvent("sp-chopshop:server:hacked-keyfob", data)
    else
        QBCore.Functions.Notify("Загубеняк...", "error", 3000)

        NetworkFadeOutEntity(clientSideVeh, false, false)
        Wait(1000)
        DeleteEntity(clientSideVeh)

        TriggerServerEvent("sp-chopshop:server:end-job")
    end
end

lib.callback.register('sp-choshop:client:spawn-vehicle', function(Job, GroupId)
    local Plate = SpawnVehicle(Job.Vehicle, Job.VehicleCoords.x, Job.VehicleCoords.y, Job.VehicleCoords.z, Job.VehicleCoords.w)

    return Plate
end)

RegisterNetEvent("sp-chopshop:client:enter-vehicle-zone", function(Job, GroupId, Plate)
    exports['sp-scanner']:SetupDigiScanner(vector3(Job.ScannerCoords.x, Job.ScannerCoords.y, Job.ScannerCoords.z), {
        event = HackKeyFob,
        isAction = true,
        args = {['GroupId'] = tostring(GroupId), ['Plate'] = tostring(Plate), ['Coords'] = Job.DogCoords},
        interact = {
            interactKey = 38,
            interactMessage = 'Хакни Системата',
        }
    })
end)

function EnterVehicleZone(GroupId)
    TriggerServerEvent("sp-chopshop:server:enter-vehicle-zone", GroupId)
end

RegisterNetEvent("sp-chopshop:client:start-job", function(Job, GroupId)
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
    TriggerServerEvent("sp-chopshop:server:enter-chop-zone", GroupId)
end

RegisterNetEvent("sp-chopshop:client:chop-zone", function(Job, GroupId)
    RemoveBlip(blip)

    blip2 = AddBlipForCoord(Job.DeliveryCoords.x, Job.DeliveryCoords.y, Job.DeliveryCoords.z)
    SetBlipSprite(blip2, 225)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 1.0)
    SetBlipColour(blip2, 1)
    SetBlipAsShortRange(blip2, true)
    SetBlipRoute(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Зона за разфасоване")
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

RegisterNetEvent("sp-chopshop:client:enter-chop-zone", function(Job, GroupId)
    dropoffx, dropoffy, dropoffz = Job.DeliveryCoords.x, Job.DeliveryCoords.y, Job.DeliveryCoords.z
end)

RegisterNetEvent("sp-chopshop:client:clear-everything", function()
    Reset()
    LicensePlate, dropoffx, dropoffy, dropoffz, dropoffm, randomVeh, randomCoords = nil
end)

RegisterNetEvent("sp-choshop:client:open-chop-shop", function()
    exports.ox_inventory:openInventory('shop', { type = 'chop-shop' })
end)

exports.ox_target:addBoxZone({
    coords = vector3(471.5797, -1312.1295, 30.2579),
    size = vector3(1.4, 1.35, 4),
    options = {
        {
            event = "sp-chopshop:StartMenu",
            label = "Разсфасовай Части",
            icon = "fas fa-hammer",
        },
    }
})

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
                if exports.ox_inventory:Search('count', k) > 0 then
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
                    AttachEntityToEntity(ChopObject, ped, GetPedBoneIndex(PlayerPedId(), Items[isDoingItemAnim].bone), Items[isDoingItemAnim].x, Items[isDoingItemAnim].y, Items[isDoingItemAnim].z, Items[isDoingItemAnim].rotX, Items[isDoingItemAnim].rotY, Items[isDoingItemAnim].rotZ, true, true, false, true, 1, true)
                end
            end

            if exports.ox_inventory:Search('count', isDoingItemAnim) <= 0 then
                isDoingItemAnim = false
            end
        end
        Wait(200)
    end
end)