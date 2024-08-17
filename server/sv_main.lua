if Config.Version == "new" then
    QBCore = exports['qb-core']:GetCoreObject()
end

local Jobs = {}

local OnCooldown = false

RegisterNetEvent("sp-chopshop:syncchopcars")
AddEventHandler("sp-chopshop:syncchopcars", SyncCars)

function StartCooldown()
	SetTimeout(60000 * Config.CoolDown, function()
		OnCooldown = false
	end)
end


RegisterNetEvent("sp-choshop:server:try-start-job", function()
	local src = source
	local groupId = exports['yflip-phone']:FindGroupByMember(src)
	if groupId == 0 then
	  TriggerClientEvent("QBCore:Notify", src, {text = "Пенчо", caption = "Не те ли е страх да отидеш сам?"}, "primary", 5000)
	else
	  local members = exports['yflip-phone']:GetGroupMembers(groupId)
	  if #members < 1 then
		TriggerClientEvent("QBCore:Notify", src, {text = "Пенчо", caption = "Не те ли е страх да отидеш сам?"}, "primary", 5000)
	  else
		local leader = exports['yflip-phone']:GetGroupLeader(groupId)
		if src == leader then
		  local canStartJob = lib.callback.await('sp-choshop:client:can-start-job', src)
  
		  if canStartJob and not OnCooldown then
			Jobs[groupId] = {}
			randomVeh = math.random(1, 47)
            randomCoords = math.random(1, 60)
            randomLoc = math.random(1,4)
			Jobs[groupId]['Vehicle'] = Config.VehicleList[randomVeh].vehicle
			Jobs[groupId]['VehicleCoords'] = Config.VehicleCoords[randomCoords]['coords']
			Jobs[groupId]['ScannerCoords'] = Config.VehicleCoords[randomCoords]['scanner']
			Jobs[groupId]['DogCoords'] = Config.VehicleCoords[randomCoords]['dog']
			Jobs[groupId]['DeliveryCoords'] = Config.DeliveryCoords[randomLoc]['coords']
			Jobs[groupId]['JobData'] = {
				hood1 = false,
				trunk1 = false,
				wheel0 = false,
				wheel1 = false,
				wheel4 = false,
				wheel5 = false,
				door1 = false,
				door2 = false,
				door3 = false,
				door4 = false,
				InVehicleZone = false,
				InChopZone = false,
			}

			for i = 1, #members do
				TriggerClientEvent("sp-chopshop:client:start-job", members[i], Jobs[groupId], groupId)
				TriggerClientEvent("sp-laptop:client:show-job-stage", members[i], {
					job = "Пенчо Чопчов",
					title = "Използвай дигиталния скенер, за да намериш сигнал за ключовете",
					hasStatus = true,
					statusMessage = "Регистрационен Номер:",
					statusValue = "Не е наличен",
				})
			end

			exports['yflip-phone']:SetJobStatus(groupId, "Скрапа на Пенчо")

			OnCooldown = true

			StartCooldown()
		  else
			TriggerClientEvent('QBCore:Notify', src, 'Не може да работиш за мен...', "error", 3000)
		  end
		else
		  TriggerClientEvent('QBCore:Notify', src, 'Не си лидера на групата.', "error", 3000)
		end
	  end
	end
end)

RegisterNetEvent("sp-chopshop:server:enter-vehicle-zone", function(GroupId)
	if Jobs[GroupId] == nil or Jobs[GroupId]["JobData"]["InVehicleZone"] == true then return end

	Jobs[GroupId]["JobData"]["InVehicleZone"] = true

	local leader = exports['yflip-phone']:GetGroupLeader(GroupId)

	local spawnedVehicle = lib.callback.await('sp-choshop:client:spawn-vehicle', leader, Jobs[GroupId], GroupId)
		
	local members = exports['yflip-phone']:GetGroupMembers(GroupId)

	TriggerClientEvent("sp-chopshop:client:enter-vehicle-zone", leader, Jobs[GroupId], GroupId, spawnedVehicle)
	
	for i = 1, #members do
		TriggerClientEvent("sp-laptop:client:show-job-stage", members[i], {
			job = "Пенчо Чопчов",
			title = "Използвай дигиталния скенер (ЛИДЕР), за да намериш сигнал за ключовете",
			hasStatus = true,
			statusMessage = "Регистрационен Номер:",
			statusValue = spawnedVehicle,
		})
	end
end)

RegisterNetEvent("sp-chopshop:server:hacked-keyfob", function(data)
	local GroupId = tonumber(data['GroupId'])

	if Jobs[GroupId] == nil then return end

	local members = exports['yflip-phone']:GetGroupMembers(GroupId)

	for i = 1, #members do
		TriggerClientEvent("sp-chopshop:client:chop-zone", members[i], Jobs[GroupId], GroupId)
		TriggerClientEvent("sp-laptop:client:show-job-stage", members[i], {
			job = "Пенчо Чопчов",
			title = "Отиди на локацията за разфасоване на автомобила",
			hasStatus = false,
		})
		TriggerClientEvent("vehiclekeys:client:SetOwner", members[i], data['Plate'])
	end
end)

RegisterNetEvent("sp-chopshop:server:enter-chop-zone", function(GroupId)
	if Jobs[GroupId] == nil or Jobs[GroupId]["JobData"]["InChopZone"] == true then return end

	Jobs[GroupId]["JobData"]["InChopZone"] = true

	local members = exports['yflip-phone']:GetGroupMembers(GroupId)

	for i = 1, #members do
		TriggerClientEvent("sp-chopshop:client:enter-chop-zone", members[i], Jobs[GroupId], GroupId)
		TriggerClientEvent("sp-laptop:client:show-job-stage", members[i], {
			job = "Пенчо Чопчов",
			title = "Разфасовай автомобила",
			hasStatus = false,
		})
	end
end)

RegisterNetEvent("sp-chopshop:server:sync-scrapping", function(vehicle, tableForOthers)
	local src = source
	local groupId = exports['yflip-phone']:FindGroupByMember(src)
	if groupId ~= 0 then
		local members = exports['yflip-phone']:GetGroupMembers(groupId)
		local leader = exports['yflip-phone']:GetGroupLeader(groupId)
		if src == leader then
			for i = 1, #members do
				TriggerClientEvent("sp-chopshop:client:sync-scrapping", members[i], vehicle, tableForOthers)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, 'Не си лидера на групата.', "error", 3000)
		end
	end
end)

RegisterNetEvent("sp-chopshop:server:sync-chopping-item", function(item, index)
	local src = source
	local groupId = exports['yflip-phone']:FindGroupByMember(src)
	if groupId == 0 then return end
	if Jobs[groupId] == nil then return end

	Jobs[groupId]["JobData"][item] = true

	local members = exports['yflip-phone']:GetGroupMembers(groupId)

	for i = 1, #members do
		TriggerClientEvent("sp-chopshop:client:update-chopped-part", members[i], index)
	end
end)

RegisterNetEvent("sp-chopshop:server:end-job", function()
	local src = source
	local groupId = exports['yflip-phone']:FindGroupByMember(src)
	if groupId == 0 then return end
	if Jobs[groupId] == nil then return end

	local members = exports['yflip-phone']:GetGroupMembers(groupId)

	for i = 1, #members do
		TriggerClientEvent("sp-chopshop:client:clear-everything", members[i])
	end

	exports['yflip-phone']:SetJobStatus(groupId, "WAITING")

	Jobs[groupId] = nil
end)

RegisterNetEvent("sp-chopshop:server:player-too-far", function()
	local src = source
	local groupId = exports['yflip-phone']:FindGroupByMember(src)
	if groupId == 0 then return end
	if Jobs[groupId] == nil then return end

	local members = exports['yflip-phone']:GetGroupMembers(groupId)

	for i = 1, #members do
		TriggerClientEvent("sp-chopshop:client:player-too-far", members[i])
	end

	Jobs[groupId] = nil
end)

function GiveReward(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if data == "wheel1" or data == "wheel2" or data == "wheel3" or data == "wheel4" then
    		Player.Functions.AddItem("carpart_wheel", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_wheel'], "add")

	elseif data == "door1" or data == "door2" or data == "door3" or data == "door4" then
    	Player.Functions.AddItem("carpart_door", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_door'], "add")
		
	elseif data == "hood" then
    	Player.Functions.AddItem("carpart_hood", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_hood'], "add")

	elseif data == "trunk" then 
		local randomitem = math.random(1, 3)
		local item = Config.TrunkItems[randomitem]["item"]
		local amount = Config.TrunkItems[randomitem]["amount"]
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
		TriggerClientEvent('QBCore:Notify', src, "You found "..amount.." "..item.." in the trunk", 'success')
		Citizen.Wait(8500)
		Player.Functions.AddItem("carpart_trunk", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_trunk'], "add")
	end
end

RegisterNetEvent("sp-chopshop:server:rewardplayer")
AddEventHandler("sp-chopshop:server:rewardplayer", GiveReward)

function SyncCars(list) 
	TriggerClientEvent('sp-chopshop:carlist', -1,list) 
end

RegisterNetEvent("sp-chopshop:server:chopdoor")
AddEventHandler("sp-chopshop:server:chopdoor", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local door = "carpart_door"
	
	if Player.Functions.GetItemByName(door) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("carpart_door", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_door'], "remove")
		TriggerClientEvent('sp-chopshop:doorchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no doors to scrap..', 'error')
	end
end)

RegisterNetEvent("sp-chopshop:server:chopwheel")
AddEventHandler("sp-chopshop:server:chopwheel", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local wheel = "carpart_wheel"

	if Player.Functions.GetItemByName(wheel) ~= nil then
		local randomitem = math.random(1, 3)
		local item = Config.WheelItems[randomitem]["item"]
		local amount = Config.WheelItems[randomitem]["amount"]
		Player.Functions.RemoveItem("carpart_wheel", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_wheel'], "remove")
		TriggerClientEvent('sp-chopshop:wheelchopanim', src)
		Citizen.Wait(14000)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no wheels to scrap..', 'error')
	end
end)


RegisterNetEvent("sp-chopshop:server:chophood")
AddEventHandler("sp-chopshop:server:chophood", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local hood = "carpart_hood" 

	if Player.Functions.GetItemByName(hood) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("carpart_hood", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_hood'], "remove")
		TriggerClientEvent('sp-chopshop:hoodchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no hoods to scrap..', 'error')
	end
end)


RegisterNetEvent("sp-chopshop:server:choptrunk")
AddEventHandler("sp-chopshop:server:choptrunk", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local trunk = "carpart_trunk"

	if Player.Functions.GetItemByName(trunk) ~= nil then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		Player.Functions.RemoveItem("carpart_trunk", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['carpart_trunk'], "remove")
		TriggerClientEvent('sp-chopshop:trunkchopanim', src)
		Citizen.Wait(12500)
		Player.Functions.AddItem(item, amount, false, info)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, 'You have no trunks to scrap..', 'error')
	end
end)

-- Shop with the thing
exports.ox_inventory:RegisterShop('chop-shop', {
    name = 'Пенчо Чопчов',
    inventory = {
        { name = 'WEAPON_DIGISCANNER', price = 5000 },
    },
})

RegisterNetEvent("sp-chopshop:server:remove-lockpickable-vehicle", function(plate)
	TriggerClientEvent("sp-chopshop:client:remove-lockpickable-vehicle", -1, plate)
end)