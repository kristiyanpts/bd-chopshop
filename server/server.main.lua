local Jobs = {}
local OnCooldown = false

RegisterNetEvent("bd-chopshop:syncchopcars")
AddEventHandler("bd-chopshop:syncchopcars", SyncCars)

function StartCooldown()
	SetTimeout(60000 * Config.CoolDown, function()
		OnCooldown = false
	end)
end

RegisterNetEvent("bd-chopshop:server:try-start-job", function()
	local src = source
	local groupId = FindGroupByMember(src)
	if groupId == 0 then
		Notify(src, Config.Locale["notInaGroup"], "error", 5000)
	else
		local members = GetGroupMembers(groupId)
		if #members < 1 then
			Notify(src, Config.Locale["notEnoughMembers"], "error", 5000)
		else
			local leader = GetGroupLeader(groupId)
			if src == leader then
				local canStartJob = lib.callback.await('bd-chopshop:client:can-start-job', src)

				if canStartJob and not OnCooldown then
					Jobs[groupId] = {}
					randomVeh = math.random(1, 47)
					randomCoords = math.random(1, 60)
					randomLoc = math.random(1, 4)
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
						TriggerClientEvent("bd-chopshop:client:start-job", members[i], Jobs[groupId], groupId)
						TriggerClientEvent("bd-jobstatus:client:show-job-stage", members[i], {
							job = Config.Locale["jobBossName"],
							title = Config.Locale["jobUseScanner"],
							hasStatus = true,
							statusMessage = Config.Locale["jobPlate"],
							statusValue = Config.Locale["jobPlateNotAvai"],
						})
					end

					SetJobStatus(groupId, Config.Locale["jobBossName"])

					OnCooldown = true

					StartCooldown()
				else
					Notify(src, Config.Locale["cooldownActive"], "error", 5000)
				end
			else
				Notify(src, Config.Locale["notLeader"], "error", 5000)
			end
		end
	end
end)

RegisterNetEvent("bd-chopshop:server:enter-vehicle-zone", function(GroupId)
	if Jobs[GroupId] == nil or Jobs[GroupId]["JobData"]["InVehicleZone"] == true then return end

	Jobs[GroupId]["JobData"]["InVehicleZone"] = true

	local leader = GetGroupLeader(GroupId)

	local spawnedVehicle = lib.callback.await('bd-chopshop:client:spawn-vehicle', leader, Jobs[GroupId], GroupId)

	local members = GetGroupMembers(GroupId)

	TriggerClientEvent("bd-chopshop:client:enter-vehicle-zone", leader, Jobs[GroupId], GroupId, spawnedVehicle)

	for i = 1, #members do
		TriggerClientEvent("bd-jobstatus:client:show-job-stage", members[i], {
			job = Config.Locale["jobBossName"],
			title = Config.Locale["jobUseScanner2"],
			hasStatus = true,
			statusMessage = Config.Locale["jobPlate"],
			statusValue = spawnedVehicle,
		})
	end
end)

RegisterNetEvent("bd-chopshop:server:hacked-keyfob", function(data)
	local GroupId = tonumber(data['GroupId'])

	if Jobs[GroupId] == nil then return end

	local members = GetGroupMembers(GroupId)

	for i = 1, #members do
		TriggerClientEvent("bd-chopshop:client:chop-zone", members[i], Jobs[GroupId], GroupId)
		TriggerClientEvent("bd-jobstatus:client:show-job-stage", members[i], {
			job = Config.Locale["jobBossName"],
			title = Config.Locale["jobLocation"],
			hasStatus = false,
		})
		TriggerClientEvent("bd-chopshop:client:add-vehicle-keys", members[i], data['Plate'])
	end
end)

RegisterNetEvent("bd-chopshop:server:enter-chop-zone", function(GroupId)
	if Jobs[GroupId] == nil or Jobs[GroupId]["JobData"]["InChopZone"] == true then return end

	Jobs[GroupId]["JobData"]["InChopZone"] = true

	local members = GetGroupMembers(GroupId)

	for i = 1, #members do
		TriggerClientEvent("bd-chopshop:client:enter-chop-zone", members[i], Jobs[GroupId], GroupId)
		TriggerClientEvent("bd-jobstatus:client:show-job-stage", members[i], {
			job = Config.Locale["jobBossName"],
			title = Config.Locale["jobChopdown"],
			hasStatus = false,
		})
	end
end)

RegisterNetEvent("bd-chopshop:server:sync-scrapping", function(vehicle, tableForOthers)
	local src = source
	local groupId = FindGroupByMember(src)
	if groupId ~= 0 then
		local members = GetGroupMembers(groupId)
		local leader = GetGroupLeader(groupId)
		if src == leader then
			for i = 1, #members do
				TriggerClientEvent("bd-chopshop:client:sync-scrapping", members[i], vehicle, tableForOthers)
			end
		else
			Notify(src, Config.Locale["notLeader"], "error", 5000)
		end
	end
end)

RegisterNetEvent("bd-chopshop:server:sync-chopping-item", function(item, index)
	local src = source
	local groupId = FindGroupByMember(src)
	if groupId == 0 then return end
	if Jobs[groupId] == nil then return end

	Jobs[groupId]["JobData"][item] = true

	local members = GetGroupMembers(groupId)

	for i = 1, #members do
		TriggerClientEvent("bd-chopshop:client:update-chopped-part", members[i], index)
	end
end)

RegisterNetEvent("bd-chopshop:server:end-job", function()
	local src = source
	local groupId = FindGroupByMember(src)
	if groupId == 0 then return end
	if Jobs[groupId] == nil then return end

	local members = GetGroupMembers(groupId)

	for i = 1, #members do
		TriggerClientEvent("bd-chopshop:client:clear-everything", members[i])
	end

	SetJobStatus(groupId, "WAITING")

	Jobs[groupId] = nil
end)

RegisterNetEvent("bd-chopshop:server:player-too-far", function()
	local src = source
	local groupId = FindGroupByMember(src)
	if groupId == 0 then return end
	if Jobs[groupId] == nil then return end

	local members = GetGroupMembers(groupId)

	for i = 1, #members do
		TriggerClientEvent("bd-chopshop:client:player-too-far", members[i])
	end

	Jobs[groupId] = nil
end)

function GiveReward(data)
	local src = source

	if data == "wheel1" or data == "wheel2" or data == "wheel3" or data == "wheel4" then
		AddItem(src, "carpart_wheel", 1)
	elseif data == "door1" or data == "door2" or data == "door3" or data == "door4" then
		AddItem(src, "carpart_door", 1)
	elseif data == "hood" then
		AddItem(src, "carpart_hood", 1)
	elseif data == "trunk" then
		local randomitem = math.random(1, 3)
		local item = Config.TrunkItems[randomitem]["item"]
		local amount = Config.TrunkItems[randomitem]["amount"]
		AddItem(src, item, amount)
		local text = string.format(Config.Locale["foundItem"], amount, item)
		Notify(src, text, "success", 5000)
		Wait(8500)
		AddItem(src, "carpart_trunk", 1)
	end
end

RegisterNetEvent("bd-chopshop:server:rewardplayer")
AddEventHandler("bd-chopshop:server:rewardplayer", GiveReward)

function SyncCars(list)
	TriggerClientEvent('bd-chopshop:carlist', -1, list)
end

RegisterNetEvent("bd-chopshop:server:chopdoor")
AddEventHandler("bd-chopshop:server:chopdoor", function()
	local src = source
	local door = "carpart_door"

	if HasItem(src, door) then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		RemoveItem(src, "carpart_door", 1)
		TriggerClientEvent('bd-chopshop:doorchopanim', src)
		Wait(12500)
		AddItem(src, item, amount)
	else
		Notify(src, Config.Locale["noDoors"], "error", 5000)
	end
end)

RegisterNetEvent("bd-chopshop:server:chopwheel")
AddEventHandler("bd-chopshop:server:chopwheel", function()
	local src = source
	local wheel = "carpart_wheel"

	if HasItem(src, wheel) then
		local randomitem = math.random(1, 3)
		local item = Config.WheelItems[randomitem]["item"]
		local amount = Config.WheelItems[randomitem]["amount"]
		RemoveItem(src, "carpart_wheel", 1)
		TriggerClientEvent('bd-chopshop:wheelchopanim', src)
		Wait(14000)
		AddItem(src, item, amount)
	else
		Notify(src, Config.Locale["noWheels"], "error", 5000)
	end
end)


RegisterNetEvent("bd-chopshop:server:chophood")
AddEventHandler("bd-chopshop:server:chophood", function()
	local src = source
	local hood = "carpart_hood"

	if HasItem(src, hood) then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		RemoveItem(src, "carpart_hood", 1)
		TriggerClientEvent('bd-chopshop:hoodchopanim', src)
		Wait(12500)
		AddItem(src, item, amount)
	else
		Notify(src, Config.Locale["noHood"], "error", 5000)
	end
end)


RegisterNetEvent("bd-chopshop:server:choptrunk")
AddEventHandler("bd-chopshop:server:choptrunk", function()
	local src = source
	local trunk = "carpart_trunk"

	if HasItem(src, trunk) then
		local randomitem = math.random(1, 5)
		local item = Config.DoorItems[randomitem]["item"]
		local amount = Config.DoorItems[randomitem]["amount"]
		RemoveItem(src, "carpart_trunk", 1)
		TriggerClientEvent('bd-chopshop:trunkchopanim', src)
		Wait(12500)
		AddItem(src, item, amount)
	else
		Notify(src, Config.Locale["noTrunk"], "error", 5000)
	end
end)

CreateThread(function()
	local items = {
		{ name = 'WEAPON_DIGISCANNER', amount = 1000, price = 5000 },
	}
	if Config.Core.Inventory == "ox_inventory" then
		exports.ox_inventory:RegisterShop('chop-shop', {
			name = Config.Locale["jobBossName"],
			inventory = items,
		})
	elseif Config.Core.Inventory == "qb-inventory" then
		exports['qb-inventory']:AddShop('chop-shop', 'Пенчо Чопчов', {
			{ name = 'WEAPON_DIGISCANNER', price = 5000 },
		})

		exports['qb-inventory']:CreateShop({
			name = 'chop-shop',
			label = Config.Locale["jobBossName"],
			slots = #items,
			items = items
		})
	elseif Config.Core.Inventory == "codem-inventory" then
		shopname = 'chop-shop',
		RegisterNetEvent('codem-inventory:openshop', function(shopname)
			if Config.Shops[shopname] then
				OpenInventoryShop(shopname, Config.Shops[shopname])
			else
				print('not found shop')
			end
		end)
			
	elseif Config.Core.Inventory == "custom" then
		-- Add your own inventory system here
	else
		debugPrint("Inventory system not supported. Supported inventory systems: ox_inventory, qb-inventory, custom")
	end
end)

RegisterNetEvent("bd-chopshop:server:remove-lockpickable-vehicle", function(plate)
	TriggerClientEvent("bd-chopshop:client:remove-lockpickable-vehicle", -1, plate)
end)

RegisterNetEvent("bd-chopshop:server:open-chop-shop", function()
	exports['qb-inventory']:OpenShop(source, 'chop-shop')
end)

RegisterNetEvent("bd-chopshop:server:sync-wheel", function(tier, offset)
	local src = source
	local groupId = FindGroupByMember(src)
	if groupId ~= 0 then
		local members = GetGroupMembers(groupId)

		for i = 1, #members do
			if members[i] ~= src then
				TriggerClientEvent("bd-chopshop:client:sync-wheel", members[i], tier, offset)
			end
		end
	end
end)

RegisterNetEvent("bd-chopshop:server:sync-door", function(door)
	local src = source
	local groupId = FindGroupByMember(src)
	if groupId ~= 0 then
		local members = GetGroupMembers(groupId)

		for i = 1, #members do
			if members[i] ~= src then
				TriggerClientEvent("bd-chopshop:client:sync-door", members[i], door)
			end
		end
	end
end)
