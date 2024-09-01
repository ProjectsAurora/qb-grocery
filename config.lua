Config = {}

-- Blip Configuration
Config.Blip = {
    coords = vector3(-1120.73, -1363.57, 5.04),
    sprite = 52,
    color = 8,
    name = "Grocery Store"
}

-- Restock Configuration
Config.Restock = {
    autoRestock = true, -- Set to true to enable auto restock, false to disable
    maxStock = 50, -- Maximum stock level after restock
    timer = 120, -- Timer for restock in seconds (e.g., 3600 seconds = 1 hour)
    cost = 1000 -- Cost for restocking
}


Config.RestockLocation = {
    coords = vector3(-1119.51, -1349.64, 5.04),  -- Replace with your coordinates
    size = {x = 1.0, y = 1.0},  -- Size of the target zone
    heading = 0,  -- Heading for the zone
    minZ = 5.00,  -- Minimum Z coordinate
    maxZ = 6.42  -- Maximum Z coordinate
}


-- Storage Location Configuration
Config.StorageLocation = {
    name = "GroceryStorage",
    coords = vector3(-1121.38, -1352.74, 5.04), -- Updated coordinates
    heading = 347.27,
    minZ = 2.0, 
    maxZ = 8.0, 
    size = {x = 0.9, y = 0.9}, -- Size of the target zone
}

-- Job Name Configuration
Config.Jobname = "grocery" -- Don't change unless you know what you're doing 


-- Config for delivery jobs
Config.DeliveryJobs = {
    Locations = {
        { coords = vector3(-41.79, 1884.18, 195.52), payment = 100 },
        { coords = vector3(1552.2, 2189.59, 78.84), payment = 100 },
        { coords = vector3(1332.48, 4325.15, 38.25), payment = 100 },
        -- Add more delivery locations here i added money so if further better pay
    }
}

-- Config for starting delivery location 
Config.DeliveryStart = {
    Locations = {
        {
            id = 1,
            coords = vector3(-1112.85, -1370.41, 5.13), -- Example coordinates
            heading = 0, 
            minZ = 4.0, 
            maxZ = 6.0, 
        },
        -- Add more starting locations here
    }
}


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
            {name = "lettuce", label = "Lettuce", price = 7, stock = 50}, 
            {name = "tomato", label = "Tomato", price = 6, stock = 50} 
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
            {name = "steak", label = "Steak", price = 20, stock = 50}, 
            {name = "chicken", label = "Chicken", price = 15, stock = 50}, 
            {name = "pork", label = "Pork", price = 18, stock = 50} 
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
            {name = "icecream", label = "Ice Cream", price = 10, stock = 50}, 
            {name = "frozenpizza", label = "Frozen Burgers", price = 15, stock = 50}, 
            {name = "frozenvegetables", label = "Frozen Nuggets", price = 8, stock = 50}
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
            {name = "milk", label = "Milk", price = 3, stock = 50}, 
            {name = "cheese", label = "Cheese", price = 5, stock = 50}, 
            {name = "yogurt", label = "Yogurt", price = 4, stock = 50} 
        }
    }
}
