RegisterNetEvent('sp-chopshop:wheelanimation')
AddEventHandler('sp-chopshop:wheelanimation', function()
    -- TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
	-- local ped = PlayerPedId()
	-- TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	QBCore.Functions.Progressbar("wheel", Config.Locale["Wheel"], 7000, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
		anim = "machinic_loop_mechandplayer"
	}, {}, {}, function()
	end)
	Wait(7500)
	-- local ped = PlayerPedId()    
	-- RequestAnimDict("anim@heists@box_carry@")
	-- Wait(100)
    -- wheelprop = CreateObject(GetHashKey("imp_prop_impexp_tyre_01b"), 0, 0, 0, true, true, true)        
	-- AttachEntityToEntity(wheelprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.05, 0.2, 0.35, -145.0, 100.0, 0.0, true, true, false, true, 1, true)
	-- TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 2500, 51, 0, false, false, false)
	-- Wait(2500)
	-- DetachEntity(wheelprop, 1, true)
	-- DeleteEntity(wheelprop)
	-- DeleteObject(wheelprop)
end)

RegisterNetEvent('sp-chopshop:dooranimation')
AddEventHandler('sp-chopshop:dooranimation', function()
    -- TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	QBCore.Functions.Progressbar("Door1", Config.Locale["Door1"], 9000, false, false, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(9000)
	-- local ped = PlayerPedId()    
	-- RequestAnimDict("anim@heists@box_carry@")
	-- Wait(100)
	-- doorprop = CreateObject(GetHashKey("imp_prop_impexp_car_door_04a"), 0, 0, 0, true, true, true)  
    -- AttachEntityToEntity(doorprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.16, -0.05, 0.5, -135.0, 180.0, 0.0, true, true, false, true, 1, true)
	-- TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 2000, 51, 0, false, false, false)
	-- Wait(2000)
	-- DetachEntity(doorprop, 1, true)
	-- DeleteEntity(doorprop)
	-- DeleteObject(doorprop)
end)

RegisterNetEvent('sp-chopshop:trunkanimation')
AddEventHandler('sp-chopshop:trunkanimation', function()
    -- TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	QBCore.Functions.Progressbar("Trunk1", Config.Locale["searching"], 12000, false, false, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(1200)
end)

RegisterNetEvent('sp-chopshop:hoodanimation')
AddEventHandler('sp-chopshop:hoodanimation', function()
    -- TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	QBCore.Functions.Progressbar("Hood1", Config.Locale["Door1"], 12000, false, false, {
	    disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	Wait(12000)
	-- local ped = PlayerPedId()    
	-- RequestAnimDict("anim@heists@box_carry@")
	-- Wait(100)
	-- trunkprop = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 0, 0, 0, true, true, true)  
    -- AttachEntityToEntity(trunkprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.58, 0.35, 0.24, -120.0, 115.0, 0.0, true, true, false, true, 1, true)
	-- TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 2000, 51, 0, false, false, false)
	-- Wait(2000)
	-- DetachEntity(trunkprop, 1, true)
	-- DeleteEntity(trunkprop)
	-- DeleteObject(trunkprop)
end)

RegisterNetEvent('sp-chopshop:wheelchopanim')
AddEventHandler('sp-chopshop:wheelchopanim', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("wheel", Config.Locale["chopwheel"], 13000, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Wait(100)
    wheelprop = CreateObject(GetHashKey("imp_prop_impexp_tyre_01b"), 0, 0, 0, true, true, true)        
	AttachEntityToEntity(wheelprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.05, 0.2, 0.35, -145.0, 100.0, 0.0, true, true, false, true, 1, true)
	SetEntityCoords(ped, 472.3670, -1311.3860, 28.2159)
    SetEntityHeading(ped, 124.7478)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1500, 51, 0, false, false, false)
	Wait(1500)
	DeleteEntity(wheelprop)
	DeleteEntity(wheelprop)
	DeleteObject(wheelprop)
	wheeleobj = CreateObject(GetHashKey("imp_prop_impexp_tyre_01b"), 471.8941, -1311.6477, 29.2602, true, true, true)
	PlaceObjectOnGroundProperly(wheeleobj)
    SetEntityHeading(wheeleobj, 290.6089)
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(wheeleobj)
	DeleteEntity(wheeleobj)
	DeleteObject(wheeleobj)
end)

RegisterNetEvent('sp-chopshop:doorchopanim')
AddEventHandler('sp-chopshop:doorchopanim', function()
	local ped = PlayerPedId()    
	QBCore.Functions.Progressbar("door", Config.Locale["chopdoor"], 13000, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Wait(100)
	doorprop = CreateObject(GetHashKey("imp_prop_impexp_car_door_04a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(doorprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.08, 0.28, 0.90, -115.0, 180.0, 0.0, true, true, false, true, 1, true)
    SetEntityCoords(ped, 472.5670, -1311.3860, 28.2159)
    SetEntityHeading(ped, 124.747)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1500, 51, 0, false, false, false)
	Wait(1500)
	DetachEntity(doorprop, 1, true)
	DeleteEntity(doorprop)
	DeleteObject(doorprop)
	doorobj = CreateObject(GetHashKey("imp_prop_impexp_car_door_04a"), 471.5941, -1311.3477, 29.2602, true, true, true)
	PlaceObjectOnGroundProperly(doorobj)
    SetEntityHeading(doorobj, 37.1947)
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(doorobj)
	DeleteEntity(doorobj)
	DeleteObject(doorobj)
end)

RegisterNetEvent('sp-chopshop:hoodchopanim')
AddEventHandler('sp-chopshop:hoodchopanim', function()
	local ped = PlayerPedId()    
	QBCore.Functions.Progressbar("hood", Config.Locale["chophood"], 12500, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Wait(100)
	hoodprop = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(hoodprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.15, -0.05, 0.24, -200.0, 110.0, 0.0, true, true, false, true, 1, true)
	SetEntityCoords(ped, 472.8181, -1311.4249, 28.2183)
    SetEntityHeading(ped, 124.3253)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1000, 51, 0, false, false, false)
	Wait(1000)
	DetachEntity(hoodprop, 1, true)
	DeleteEntity(hoodprop)
	DeleteObject(hoodprop)
	hoodobj = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 471.8663, -1311.6914, 29.86, true, true, true)
    SetEntityHeading(hoodobj, 118.1908)
	SetEntityRotation(hoodobj, 0.0, 80.0)
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(hoodobj)
	DeleteEntity(hoodobj)
	DeleteObject(hoodobj)
end)

RegisterNetEvent('sp-chopshop:trunkchopanim')
AddEventHandler('sp-chopshop:trunkchopanim', function()
	local ped = PlayerPedId()
	QBCore.Functions.Progressbar("trunk", Config.Locale["choptrunk"], 12500, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function()
	end)
	RequestAnimDict("anim@heists@box_carry@")
	Wait(100)
	trunkprop = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"), 0, 0, 0, true, true, true)  
    AttachEntityToEntity(trunkprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.15, -0.05, 0.24, -200.0, 110.0, 0.0, true, true, false, true, 1, true)
	SetEntityCoords(ped, 472.5044, -1311.2794, 28.2171)
    SetEntityHeading(ped, 122.8519)
	TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 2.0, 2.0, 1000, 51, 0, false, false, false)
	Wait(1000)
	DetachEntity(trunkprop, 1, true)
	DeleteEntity(trunkprop)
	DeleteObject(trunkprop)
	trunkobj = CreateObject(GetHashKey("imp_prop_impexp_bonnet_02a"),471.7178, -1311.6902, 29.82, true, true, true)
    SetEntityHeading(trunkobj, 118.1908)   
	SetEntityRotation(trunkobj, 0.0, 250.0)
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
	Wait(12000)
	ClearPedTasks(ped)
	DeleteEntity(trunkobj)
	DeleteEntity(trunkobj)
	DeleteObject(trunkobj)
end)