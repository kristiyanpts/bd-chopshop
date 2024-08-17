Config = {}

-- EITHER "new" or "old"    If new Remove shared_scripts from the fxmanifest.lua
Config.Version = "new" -- If you use a newer version of QBCores "qb-core" (around 1 month old) then set to new otherwise set it to old

Config.CoolDown = 20       -- How long people must wait before starting another job (in minutes)

Config.EnableDog = true -- For testing purposes only inache da e true hehe

Config.EnablePolice = true -- Trqq ima kuki nqma kak reksi!

Config.CopsNeeded = 0

Config.WheelItems = {      -- Items you get when chopping a wheel
    [1] = {
        ["item"] = "aluminum",
        ["amount"] = math.random(20, 25)
    },
    [2] = {
        ["item"] = "plastic",
        ["amount"] = math.random(20, 25)
    },
    [3] = {
        ["item"] = "rubber",
        ["amount"] = math.random(20, 25)
    },
}

Config.DoorItems = {    -- Items you get when chopping a door (also includes the trunk and hood)
    [1] = {
        ["item"] = "steel",
        ["amount"] = math.random(20, 25)
    },
    [2] = {
        ["item"] = "plastic",
        ["amount"] = math.random(20, 25)
    },
    [3] = {
        ["item"] = "metalscrap",
        ["amount"] = math.random(20, 25)
    },
    [4] = {
        ["item"] = "iron",
        ["amount"] = math.random(20, 25)
    },
    [5] = {
        ["item"] = "aluminum",
        ["amount"] = math.random(20, 25)
    },
}

Config.TrunkItems = {      -- Items that players can find in the trunk of the vehicle
    [1] = {
        ["item"] = "lockpick",
        ["amount"] = math.random(1, 2)
    },
    [2] = {
        ["item"] = "joint",
        ["amount"] = math.random(1, 4)
    },
    [3] = {
        ["item"] = "weapon_bat",
        ["amount"] = 1,
    },
}

-- ***If you add or remove any of these please also change line 108 in cl_main.lua***
Config.DeliveryCoords = {  -- Locations for the scrapyards **Chosen from random every time you start a new job**
    [1] = {
        coords = vector4(2055.7080, 3179.8103, 45.1689, 91.500389),
    },
    [2] = {
        coords = vector4( 2351.7979, 3132.7310, 47.6015, 91.500389),
    },
    [3] = {
        coords = vector4(1565.4553, -2158.8508, 76.9222, 91.500389),
    },
    [4] = {
        coords = vector4(-458.0591, -1712.9053, 18.0516, 91.500389),
    },
}

-- ***If you add or remove any of these please also change line 106 in cl_main.lua***
Config.VehicleList =  {       -- All the different types of vehicles that can spawn. **Chosen from random every time you start a new job**
    [1]  = {vehicle = "Asterope"},
    [2]  = {vehicle = "Premier"},
    [3]  = {vehicle = "Primo2"},
    [4]  = {vehicle = "sultanrs"},
    [5]  = {vehicle = "Stanier"},
    [6]  = {vehicle = "Stratum"},
    [7]  = {vehicle = "Surge"},
    [8]  = {vehicle = "Tailgater"},
    [9]  = {vehicle = "Warrener"},
    [10] = {vehicle = "Washington"},
    [11] = {vehicle = "Asea"},
    [12] = {vehicle = "sultan2"},
    [13] = {vehicle = "Cog55"},
    [14] = {vehicle = "Cognoscenti"},
    [15] = {vehicle = "Emperor"},
    [16] = {vehicle = "Emperor2"},
    [17] = {vehicle = "Fugitive"},
    [18] = {vehicle = "Glendale"},
    [19] = {vehicle = "Ingot"},
    [20] = {vehicle = "Intruder"},
    [21] = {vehicle = "Buffalo"},
    [22] = {vehicle = "Kuruma"},
    [23] = {vehicle = "Schafter2"},
    [24] = {vehicle = "Schwarzer"},
    [25] = {vehicle = "Pigalle"},
    [26] = {vehicle = "Superd"},
    [27] = {vehicle = "Buffalo2"},
    [28] = {vehicle = "Felon"},
    [29] = {vehicle = "Jackal"},
    [30] = {vehicle = "Oracle"},
    [31] = {vehicle = "Sentinel"},
    [32] = {vehicle = "Dilettante"},
    [33] = {vehicle = "Blista"},
    [34] = {vehicle = "Blista2"},
    [35] = {vehicle = "Zion"},
    [36] = {vehicle = "Zion2"},
    [37] = {vehicle = "Feltzer2"},
    [38] = {vehicle = "Ninef"},
    [39] = {vehicle = "Fusilade"},
    [40] = {vehicle = "Jester"},
    [41] = {vehicle = "Carbonizzare"},
    [42] = {vehicle = "Sultan"},
    [43] = {vehicle = "Peyote"},
    [44] = {vehicle = "Buccaneer2"},
    [45] = {vehicle = "Picador"},
    [46] = {vehicle = "Virgo2"},
    [47] = {vehicle = "Brawler"},
}

-- ***If you add or remove any of these please also change line 107 in cl_main.lua***
Config.VehicleCoords = {        -- Locations of where the vehicle can spawn **Chosen from random every time you start a new job**
    [1] = {coords = vector4(-114.9003, -2526.6394, 5.3918, 235.8066), scanner = vector4(-139.14, -2518.53, 6.10, 237.46), dog = vector4(-152.01, -2505.74, 6.01, 229.91)},
    [2] = {coords = vector4(-115.1422, -2526.6729, 5.3931, 236.1575), scanner = vector4(-139.14, -2518.53, 6.10, 237.46), dog = vector4(-152.01, -2505.74, 6.01, 229.91)},
    [3] = {coords = vector4(-1074.953, -1160.545, 1.661577, 119.0), scanner = vector4(-1047.00, -1178.13, 2.16, 30.13), dog = vector4(-1044.01, -1175.03, 2.16, 211.57)},
    [4] = {coords = vector4(-1023.625, -890.4014, 5.202, 216.0399), scanner = vector4(-1011.30, -909.41, 2.13, 30.77), dog = vector4(-1014.30, -916.25, 2.13, 302.93)},
    [5] = {coords = vector4(-1609.647, -382.792, 42.70383, 52.535), scanner = vector4(-1635.98, -379.38, 43.38, 323.67), dog = vector4(-1642.96, -388.15, 43.04, 296.90)},
    [6] = {coords = vector4(-1527.88, -309.8757, 47.88678, 323.43), scanner = vector4(-1510.94, -341.59, 45.90, 135.79), dog = vector4(-1501.60, -339.54, 45.91, 48.03)},
    [7] = {coords = vector4(-1658.969, -205.1732, 54.8448, 71.138), scanner = vector4(-1679.46, -264.45, 51.88, 235.00), dog = vector4(-1689.82, -262.20, 51.88, 263.26)},
    [8] = {coords = vector4(97.57888, -1946.472, 20.27978, 215.933), scanner = vector4(75.67, -1969.97, 21.13, 319.04), dog = vector4(67.89, -1970.28, 20.87, 272.22)},
    [9] = {coords = vector4(-61.59007, -1844.621, 26.1685, 138.9848), scanner = vector4(-85.79, -1794.87, 28.44, 146.05), dog = vector4(-91.78, -1784.88, 28.81, 220.96)},
    [10] = {coords = vector4(28.51439, -1734.881, 28.5415, 231.968), scanner = vector4(29.46, -1770.29, 29.61, 227.44), dog = vector4(17.36, -1780.29, 29.23, 309.56)},
    [11] = {coords = vector4(437.5428, -1925.465, 24.004, 28.82286), scanner = vector4(424.52, -1890.17, 26.37, 228.17), dog = vector4(430.49, -1879.68, 26.92, 134.38)},
    [12] = {coords = vector4(406.5316, -1920.471, 24.51589, 224.6432), scanner = vector4(434.86, -1906.64, 25.94, 41.50), dog = vector4(435.86, -1916.10, 24.80, 37.17)},
    [13] = {coords = vector4(438.4482, -1838.672, 27.47369, 42.8129), scanner = vector4(429.07, -1819.90, 28.37, 225.46), dog = vector4(420.80, -1821.15, 27.93, 258.55)},
    [14] = {coords = vector4(187.353, -1542.984, 28.72487, 39.00627), scanner = vector4(197.28, -1493.52, 29.32, 311.89), dog = vector4(187.75, -1490.73, 29.14, 239.88)},
    [15] = {coords = vector4(1153.467, -330.2682, 68.60548, 7.20), scanner = vector4(1144.76, -299.69, 68.91, 281.35), dog = vector4(1135.98, -293.18, 68.83, 226.88)},
    [16] = {coords = vector4(1144.622, -465.7694, 66.20689, 76.612770), scanner = vector4(1127.00, -471.95, 66.60, 252.19), dog = vector4(1122.51, -464.04, 66.49, 208.86)},
    [17] = {coords = vector4(1295.844, -567.6, 70.77858, 166.552), scanner = vector4(1295.83, -590.21, 71.73, 344.64), dog = vector4(1297.83, -598.11, 72.03, 356.93)},
    [18] = {coords = vector4(1319.566, -575.9492, 72.58221, 155.9249), scanner = vector4(1315.93, -598.23, 73.25, 342.76), dog = vector4(1319.70, -607.98, 73.11, 11.03)},
    [19] = {coords = vector4(1379.466, -596.0999, 73.89736, 230.594), scanner = vector4(1399.40, -603.91, 74.49, 53.17), dog = vector4(1408.09, -603.19, 74.48, 79.50)},
    [20] = {coords = vector4(1256.648, -624.0594, 68.93141, 117.415), scanner = vector4(1239.40, -623.22, 69.36, 206.07), dog = vector4(1230.60, -623.17, 69.57, 300.87)},
    [21] = {coords = vector4(1368.127, -748.2613, 66.62316, 231.535), scanner = vector4(1340.99, -772.73, 66.73, 340.35), dog = vector4(1341.86, -784.02, 67.69, 329.76)},
    [22] = {coords = vector4(981.7167, -709.7389, 57.18427, 128.729), scanner = vector4(968.93, -724.10, 57.86, 46.82), dog = vector4(969.48, -729.51, 57.90, 4.22)},
    [23] = {coords = vector4(958.206, -662.7545, 57.57119, 116.9299), scanner = vector4(945.15, -677.88, 58.45, 300.00), dog = vector4(938.50, -684.18, 58.01, 309.51)},
    [24] = {coords = vector4(-2012.404, 484.0458, 106.5597, 78.13), scanner = vector4(-2036.37, 496.47, 107.01, 256.39), dog = vector4(-2036.37, 496.47, 107.01, 256.39)},
    [25] = {coords = vector4(-2001.294, 454.7647, 102.0194, 108.1178), scanner = vector4(-2018.29, 434.11, 102.67, 18.89), dog = vector4(-2026.06, 428.81, 103.05, 299.79)},
    [26] = {coords = vector4(-1994.725, 377.4933, 94.04324, 89.64067), scanner = vector4(-2020.27, 369.95, 94.58, 270.05), dog = vector4(-2029.67, 373.03, 94.48, 255.39)},
    [27] = {coords = vector4(-1967.549, 262.1507, 86.23506, 109.1846), scanner = vector4(-1980.79, 244.30, 87.81, 291.04), dog = vector4(-1983.97, 236.63, 87.19, 351.39)},
    [28] = {coords = vector4(-989.6796, 418.4977, 74.731, 20.262), scanner = vector4(-987.59, 451.55, 79.97, 201.36), dog = vector4(-998.14, 447.30, 79.97, 300.12)},
    [29] = {coords = vector4(-979.6517, 518.119, 81.03075, 328.386), scanner = vector4(-956.67, 526.74, 81.86, 147.88), dog = vector4(-944.89, 522.41, 81.63, 65.78)},
    [30] = {coords = vector4(-1040.915, 496.5622, 82.52803, 54.439), scanner = vector4(-1052.52, 522.75, 84.58, 43.07), dog = vector4(-1058.81, 522.13, 84.38, 265.69)},
    [31] = {coords = vector4(-1094.621, 439.2605, 74.84596, 84.936), scanner = vector4(-1112.62, 440.32, 75.48, 84.00), dog = vector4(-1113.41, 436.34, 75.29, 351.86)},
    [32] = {coords = vector4(-1236.895, 487.9722, 92.82943, 330.6634), scanner = vector4(-1217.91, 506.67, 95.86, 183.76), dog = vector4(-1216.58, 501.65, 95.67, 16.56)},
    [33] = {coords = vector4(-1209.098, 557.9588, 99.04235, 3.2526), scanner = vector4(-1193.08, 564.11, 100.34, 187.37), dog = vector4(-1190.24, 560.62, 100.13, 86.59)},
    [34] = {coords = vector4(-1155.296, 565.4297, 101.3919, 7.4106), scanner = vector4(-1164.13, 588.36, 101.88, 13.24), dog = vector4(-1161.09, 588.71, 101.83, 76.36)},
    [35] = {coords = vector4(-1105.378, 551.5797, 102.1759, 211.7110), scanner = vector4(-1097.94, 538.82, 102.81, 214.72), dog = vector4(-1099.38, 536.66, 102.70, 289.24)},
    [36] = {coords = vector4(1708.02, 3775.486, 34.08183, 35.04580), scanner = vector4(1703.22, 3791.26, 34.81, 31.83), dog = vector4(1705.73, 3794.76, 34.79, 103.88)},
    [37] = {coords = vector4(2113.365, 4770.113, 40.72895, 297.5323), scanner = vector4(2146.01, 4782.21, 41.00, 118.52), dog = vector4(2145.02, 4779.04, 40.97, 329.55)},
    [38] = {coords = vector4(2865.448, 1512.715, 24.12726, 252.3262), scanner = vector4(2854.92, 1501.94, 24.78, 76.79), dog = vector4(2854.33, 1506.47, 24.72, 197.66)},
    [39] = {coords = vector4(1413.973, 1119.024, 114.3981, 305.99868), scanner = vector4(1407.20, 1127.86, 114.33, 190.60), dog = vector4(1409.26, 1129.03, 114.33, 187.83)},
    [40] = {coords = vector4(-78.39651, 497.4749, 143.9646, 160.2948), scanner = vector4(-66.85, 489.95, 144.88, 347.75), dog = vector4(-69.02, 493.25, 144.55, 266.34)},
    [41] = {coords = vector4(-248.9841, 492.9105, 125.0711, 208.5761), scanner = vector4(-225.54, 477.92, 128.62, 199.83), dog = vector4(-222.22, 475.17, 128.43, 45.89)},
    [42] = {coords = vector4(14.09792, 548.8402, 175.7571, 241.4019775), scanner = vector4(25.14, 541.03, 176.03, 59.54), dog = vector4(24.40, 544.41, 176.03, 164.86)},
    [43] = {coords = vector4(51.48445, 562.2509, 179.8492, 203.159), scanner = vector4(45.95, 555.81, 180.19, 26.94), dog = vector4(42.99, 557.78, 180.13, 272.09)},
    [44] = {coords = vector4(-319.3912, 478.9731, 111.7186, 298.7645), scanner = vector4(-311.83, 475.11, 111.82, 117.16), dog = vector4(-315.46, 472.61, 110.26, 304.50)},
    [45] = {coords = vector4(-202.0035, 410.2064, 110.0086, 195.6136), scanner = vector4(-200.19, 382.92, 109.49, 201.80), dog = vector4(-197.22, 380.12, 109.48, 53.97)},
    [46] = {coords = vector4(-352.06, 426.29, 110.59, 316.69), scanner = vector4(-371.51, 408.44, 110.69, 115.79), dog = vector4(-373.94, 411.46, 110.59, 199.07)},
    [47] = {coords = vector4(213.5159, 389.3123, 106.4154, 348.890255), scanner = vector4(225.51, 379.22, 106.52, 75.68), dog = vector4(223.04, 375.85, 106.47, 319.46)},
    [48] = {coords = vector4(323.7256, 343.3308, 104.761, 345.49426), scanner = vector4(310.08, 354.59, 105.32, 254.21), dog = vector4(311.49, 350.76, 105.31, 4.15)},
    [49] = {coords = vector4(701.1197, 254.4424, 92.85217, 240.6288), scanner = vector4(751.54, 223.97, 87.42, 151.42), dog = vector4(747.88, 223.31, 87.18, 270.25)},
    [50] = {coords = vector4(656.4758, 184.8482, 94.53828, 248.9376), scanner = vector4(638.20, 205.75, 97.60, 347.21), dog = vector4(640.94, 206.21, 97.31, 91.89)},
    [51] = {coords = vector4(615.5524, 161.4801, 96.91451, 69.2577), scanner = vector4(583.97, 138.28, 99.47, 158.61), dog = vector4(586.61, 136.03, 99.10, 50.80)},
    [52] = {coords = vector4(899.2693, -41.99047, 78.32366, 28.13086), scanner = vector4(974.24, 12.98, 81.04, 243.23), dog = vector4(973.93, 8.83, 81.04, 288.52)},
    [53] = {coords = vector4(842.76, -190.92, 72.67, 149.04), scanner = vector4(840.87, -182.11, 74.59, 64.76), dog = vector4(837.85, -183.85, 72.93, 321.16)},
    [54] = {coords = vector4(941.2477, -248.0161, 68.15629, 328.122), scanner = vector4(930.57, -245.13, 69.00, 236.94), dog = vector4(930.40, -248.71, 68.48, 349.97)},
    [55] = {coords = vector4(871.09, -205.26, 70.77, 146.53), scanner = vector4(880.38, -205.07, 71.98, 149.59), dog = vector4(876.39, -203.58, 71.98, 244.14)},
    [56] = {coords = vector4(534.3583, -26.7027, 70.18916, 30.70978), scanner = vector4(535.81, -21.59, 70.63, 125.83), dog = vector4(535.96, -25.74, 70.63, 29.88)},
    [57] = {coords = vector4(302.5077, -176.5727, 56.95071, 249.3339), scanner = vector4(313.38, -174.40, 58.12, 155.54), dog = vector4(307.29, -173.87, 57.85, 245.19)},
    [58] = {coords = vector4(85.26346, -214.7179, 54.05132, 160.2142), scanner = vector4(101.67, -222.40, 54.64, 66.79), dog = vector4(96.45, -222.80, 54.64, 265.50)},
    [59] = {coords = vector4(78.38569, -198.4182, 55.79539, 70.1377), scanner = vector4(82.03, -219.84, 54.64, 341.91), dog = vector4(77.01, -216.03, 54.64, 236.99)},
    [60] = {coords = vector4(-30.09893, -89.37914, 56.8136, 340.32879), scanner = vector4(-22.86, -87.62, 57.27, 74.46), dog = vector4(-25.08, -83.93, 57.25, 193.54)},
}

-- All Text used in the script (you can change any of the text you want)
Config.Locale = {
    -- Notifications
    ["Reminder"] 			= "Remove parts from the vehicle then get back into it to to crush it!",
	["FarAway"] 			= "Твърде много се отдалечихте от колата. Тя ще бъде изпратена за унищожаване!",
    ["CoolDown"]            = "Изчакай малко, де!",
    ["JobActive"]           = "Вече имаш активна задача!",
    ["Email"]               = "I will send information to your email.",
    ["WrongVeh"]            = "Това не е правилния автомобил.",
    ["FoundVeh"]            = "Nice, You found the right car!",
    ["ScrapBlip"]           = "Sending scrapyard location to your GPS...",


    -- Draw Text
    ["chop"] 			    = "[E] Започни Разфасовка",
	["remove"] 				= "[E] Премахни ",
	["destroy"] 			= "[E] Унищожи Кола ",
    ["reqjob"] 			    = "[E] Поискайте информация за превозното средство",
	["Trunk"]				= "Багажник",				
	["Hood"]				= "Капак",				
	["Frontleftdoor"]		= "предна лява врата",	
	["Backleftdoor"]		= "задна лява врата",		
	["Frontrightdoor"]		= "предна дясна врата",	
	["Backrightdoor"]		= "задна дясна врата",	
	["Frontleftwheel"]		= "предна лява гума",	
	["Backleftwheel"]		= "задна лява гума",	
	["Rightfrontwheel"]		= "предна дясна гума",	
	["Rightbackwheel"]		= "задна дясна гума",	

    -- Progress Bars
    ["Wheel"] 				= "Сваляте гумата",
	["Door1"] 		        = "Отвивате болтовете",
	["Door2"] 		        = "Пантите се разпадат",
	["crushing"] 			= "Изпращате колата за унищожаване",
    ["searching"]           = "Обирате багажника",

    ["chopwheel"]           = "Режете гумата",
    ["chopdoor"]           = "Режете вратата",
    ["choptrunk"]           = "Режете багажника",
    ["chophood"]           = "Режете капака",
}

Config.CarTable = {
    {name = Config.Locale["Trunk"],			    coords = 0,	    vehBone = "boot", 		        distance = 1.5,		chopped = false,	anim = "trunk",	    	destroy = 5,	getin = 5},
	{name = Config.Locale["Hood"],			    coords = 0,	    vehBone = "overheat",		    distance = 0.8,		chopped = false,	anim = "hood",	    	destroy = 4,	getin = 4},
	{name = Config.Locale["Frontleftdoor"],	    coords = 0,	    vehBone = "door_dside_f",       distance = 0.8,	 	chopped = false,	anim = "door1",	    	destroy = 0, 	getin = 0},
	{name = Config.Locale["Backleftdoor"],	    coords = 0,	    vehBone = "door_dside_r",	    distance = 0.8,		chopped = false,	anim = "door2",	    	destroy = 2, 	getin = 2},
	{name = Config.Locale["Frontrightdoor"],	coords = 0,	    vehBone = "door_pside_f",	    distance = 0.8,		chopped = false,	anim = "door3",	    	destroy = 1, 	getin = -1},
	{name = Config.Locale["Backrightdoor"],	    coords = 0,	    vehBone = "door_pside_r",	    distance = 0.8,		chopped = false,	anim = "door4",	   	 	destroy = 3, 	getin = 1},
	{name = Config.Locale["Frontleftwheel"],	coords = 0,	    vehBone = "wheel_lf", 	        distance = 1.3,	 	chopped = false,	anim = "wheel1",	    destroy = 0,	getin = 0},
	{name = Config.Locale["Backleftwheel"],	    coords = 0,	    vehBone = "wheel_lr",		    distance = 1.3,		chopped = false,	anim = "wheel2",	    destroy = 4,	getin = 0},
	{name = Config.Locale["Rightfrontwheel"],	coords = 0,	    vehBone = "wheel_rf",		    distance = 1.3,		chopped = false,	anim = "wheel3",	    destroy = 1,	getin = 0},
	{name = Config.Locale["Rightbackwheel"],	coords = 0,	    vehBone = "wheel_rr",		    distance = 1.3,		chopped = false,	anim = "wheel4",	    destroy = 5,	getin = 0},
}
