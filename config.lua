Config = {}

Config.Shops = {
    [1] = {
        coords = vector3(-1120.73, -1363.57, 5.04), -- Vegetables
        shopName = "Vegetables",
        targetLabel = "Vegetables Shop",
        boxZone = {2.5, 2.5},  -- width, length
        heading = 0,
        minZ = 4.08,
        maxZ = 6.04,
        icon = "fas fa-carrot", -- Icon for the menu
        items = {
            {name = "carrot", price = 5},
            {name = "lettuce", price = 7},
            {name = "tomato", price = 6}
        }
    },
    [2] = {
        coords = vector3(-1123.41, -1358.45, 5.04), -- Meat
        shopName = "Meat",
        targetLabel = "Meat Shop",
        boxZone = {2.0, 2.0},
        heading = 0,
        minZ = 4.08,
        maxZ = 6.03,
        icon = "fas fa-drumstick-bite", -- Icon for the menu
        items = {
            {name = "steak", price = 20},
            {name = "chicken", price = 15},
            {name = "pork", price = 18}
        }
    },
    [3] = {
        coords = vector3(-1118.44, -1357.16, 5.04), -- Frozen Foods
        shopName = "Frozen Foods",
        targetLabel = "Frozen Foods Shop",
        boxZone = {2.0, 2.0},
        heading = 0,
        minZ = 4.2,
        maxZ = 6.2,
        icon = "fas fa-snowflake", -- Icon for the menu
        items = {
            {name = "ice_cream", price = 10},
            {name = "frozen_pizza", price = 15},
            {name = "frozen_vegetables", price = 8}
        }
    },
    [4] = {
        coords = vector3(-1240.1, -1455.9, 3.3), -- Drinks
        shopName = "Drinks",
        targetLabel = "Drinks Shop",
        boxZone = {2.5, 2.5},
        heading = 0,
        minZ = 1.3,
        maxZ = 5.3,
        icon = "fas fa-cocktail", -- Icon for the menu
        items = {
            {name = "beer", price = 5},
            {name = "whiskey", price = 20},
            {name = "vodka", price = 25}
        }
    },
    [5] = {
        coords = vector3(373.1, 325.1, 103.6), -- Dairy
        shopName = "Dairy",
        targetLabel = "Dairy Shop",
        boxZone = {2.5, 2.5},
        heading = 0,
        minZ = 101.6,
        maxZ = 105.6,
        icon = "fas fa-cheese", -- Icon for the menu
        items = {
            {name = "milk", price = 3},
            {name = "cheese", price = 5},
            {name = "yogurt", price = 4}
        }
    }
}

-- Global Blip Configuration
Config.Blip = {
    coords = vector3(-1120.73, -1363.57, 5.04), -- Example location
    sprite = 52,
    color = 2,
    name = "Grocery Store"
}
