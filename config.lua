Config = {}

-- Blip Configuration
Config.Blip = {
    coords = vector3(-1120.73, -1363.57, 5.04),
    sprite = 52,
    color = 2,
    name = "Grocery Store"
}

-- Restock Configuration
Config.Restock = {
    maxStock = 50, -- Maximum stock level after restock
    timer = 120, -- Timer for restock in seconds (e.g., 3600 seconds = 1 hour)
    cost = 1000 -- Cost for restocking
}

Config.RestockLocation = {
    coords = vector3(-1110.37, -1361.77, 5.04), -- Example coordinates
    radius = 3.0, -- Radius for the interaction zone
    heading = 0,
    minZ = 4.0,
    maxZ = 6.0
}


-- Storage Location Configuration
Config.StorageLocation = {
    name = "GroceryStorage",
    coords = vector3(-1121.38, -1352.74, 5.04), -- Updated coordinates
    heading = 347.27,
    minZ = 2.0, -- Adjusted based on the subtraction of 2
    maxZ = 8.0, -- Adjusted based on the addition of 2
    size = {x = 0.9, y = 0.9}, -- Size of the target zone
}

-- Job Name Configuration
Config.Jobname = "grocery" -- Don't change unless you know what you're doing 

-- Shops Configuration
Config.Shops = {
    ["Vegetables"] = {
        coords = vector3(-1120.73, -1363.57, 5.04),
        shopName = "Vegetables",
        targetLabel = "Vegetables Shop",
        boxZone = {2.5, 2.5},
        heading = 0,
        minZ = 4.08,
        maxZ = 6.04,
        icon = "fas fa-carrot",
        items = {
            {name = "cheese", label = "Cheese", price = 5, stock = 50},
            {name = "lettuce", label = "Lettuce", price = 7, stock = 50}, -- Corrected case for "lettuce"
            {name = "tomato", label = "Tomato", price = 6, stock = 50} -- Corrected case for "tomato"
        }
    },
    ["Meat"] = {
        coords = vector3(-1123.41, -1358.45, 5.04),
        shopName = "Meat",
        targetLabel = "Meat Shop",
        boxZone = {2.0, 2.0},
        heading = 0,
        minZ = 4.08,
        maxZ = 6.03,
        icon = "fas fa-drumstick-bite",
        items = {
            {name = "steak", label = "Steak", price = 20, stock = 50}, -- Corrected case for "steak"
            {name = "chicken", label = "Chicken", price = 15, stock = 50}, -- Corrected case for "chicken"
            {name = "pork", label = "Pork", price = 18, stock = 50} -- Corrected case for "pork"
        }
    },
    ["Frozen Foods"] = {
        coords = vector3(-1118.44, -1357.16, 5.04),
        shopName = "Frozen Foods",
        targetLabel = "Frozen Foods Shop",
        boxZone = {2.0, 2.0},
        heading = 0,
        minZ = 4.2,
        maxZ = 6.2,
        icon = "fas fa-snowflake",
        items = {
            {name = "icecream", label = "Ice Cream", price = 10, stock = 50}, -- Corrected case for "icecream"
            {name = "frozenpizza", label = "Frozen Burgers", price = 15, stock = 50}, -- Corrected case for "frozenpizza"
            {name = "frozenvegetables", label = "Frozen Nuggets", price = 8, stock = 50} -- Corrected case for "frozenvegetables"
        }
    },
    ["Drinks"] = {
        coords = vector3(-1114.29, -1357.6, 5.04),
        shopName = "Drinks",
        targetLabel = "Drinks Shop",
        boxZone = {2.5, 2.5},
        heading = 0,
        minZ = 4.0,
        maxZ = 6.3,
        icon = "fas fa-cocktail",
        items = {
            {name = "beer", label = "Beer", price = 5, stock = 50},
            {name = "whiskey", label = "Whiskey", price = 20, stock = 50},
            {name = "vodka", label = "Vodka", price = 25, stock = 50}
        }
    },
    ["Dairy"] = {
        coords = vector3(373.1, 325.1, 103.6),
        shopName = "Dairy",
        targetLabel = "Dairy Shop",
        boxZone = {2.5, 2.5},
        heading = 0,
        minZ = 101.6,
        maxZ = 105.6,
        icon = "fas fa-cheese",
        items = {
            {name = "milk", label = "Milk", price = 3, stock = 50}, -- Corrected case for "milk"
            {name = "cheese", label = "Cheese", price = 5, stock = 50}, -- Corrected case for "cheese"
            {name = "yogurt", label = "Yogurt", price = 4, stock = 50} -- Corrected case for "yogurt"
        }
    }
}
