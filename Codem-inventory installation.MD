## Installation Guide For Codem-Inventory (by Procastinator dv)
Step 1: In the config change the inventory to codem-inventory
Step 2: Add the items in items.lua to both qb-core/shared/items.lua and to codem-inventory/config/itemlist.lua
Step 3: Add the following lines to codem-inventory/config/shops.lua
        Only add it after changing the vector to the vector u require 
``
        ["chop-shop"] = {
            label = "Chop Shop",
            Blip = {
                enable = false, -- show blip = true  -- hide blip false
                id = 1,
                scale = 0.5,
                color = 5,
            },
            job = 'all',
            items = {
                ["1"] = { name = "WEAPON_DIGISCANNER", price = 5000,},
             },
            coords = vector3(0, 0, 0), **replace with your coords**
        },
``
Step 4: Follow the rest like in the documentation [here](https://docs.bulgar.dev/)
