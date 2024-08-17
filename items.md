# ox_inventory

## data/items.lua

```lua
	["carpart_wheel"] = {
		label = "Wheel",
		weight = 10000,
		stack = false,
		close = false,
		description = "Wheel from a car",
		client = {
			image = "carpart_wheel.png",
		}
	},
	["carpart_door"] = {
		label = "Door",
		weight = 10000,
		stack = false,
		close = false,
		description = "Door from a car",
		client = {
			image = "carpart_door.png",
		}
	},
	["carpart_hood"] = {
		label = "Hood",
		weight = 10000,
		stack = false,
		close = false,
		description = "Hood from a car",
		client = {
			image = "carpart_hood.png",
		}
	},
	["carpart_trunk"] = {
		label = "Trunk",
		weight = 10000,
		stack = false,
		close = false,
		description = "Trunk from a car",
		client = {
			image = "carpart_trunk.png",
		}
	},
```

## data/weapons.lua

```lua
    ['WEAPON_DIGISCANNER'] = {
        label = 'Digital Scanner',
        weight = 125,
        durability = 0.1,
    },
```

# qb-core

## shared/items.lua

```lua
    carpart_wheel = { name = 'carpart_wheel', label = 'Wheel', weight = 10000, type = 'item', image = 'carpart_wheel.png', unique = true, useable = false, shouldClose = false, description = 'Wheel from a car' },

    carpart_door = { name = 'carpart_door', label = 'Door', weight = 10000, type = 'item', image = 'carpart_door.png', unique = true, useable = false, shouldClose = false, description = 'Door from a car' },

    carpart_hood = { name = 'carpart_hood', label = 'Hood', weight = 10000, type = 'item', image = 'carpart_hood.png', unique = true, useable = false, shouldClose = false, description = 'Hood from a car' },

    carpart_trunk = { name = 'carpart_trunk', label = 'Trunk', weight = 10000, type = 'item', image = 'carpart_trunk.png', unique = true, useable = false, shouldClose = false, description = 'Trunk from a car' },
```

## shared/weapons.lua

```lua
	[`weapon_digiscanner`] = {['name'] = 'weapon_digiscanner', 		['label'] = 'Digital Scanner', 			['weapontype'] = 'Melee',	['ammotype'] = nil,	['damagereason'] = 'Melee killed / Whacked / Executed / Beat down / Murdered / Battered', ['image'] = "WEAPON_DIGISCANNER.png" },
```
