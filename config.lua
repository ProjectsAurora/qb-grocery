Config = {}

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
            {name = "cheese", label = "Cheese", price = 5, stock = 10},
            {name = "Lettuce", label = "Lettuce", price = 7, stock = 10},
            {name = "Tomato", label = "Tomato", price = 6, stock = 10}
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
            {name = "Steak", label = "Steak", price = 20, stock = 15},
            {name = "Chicken", label = "Chicken", price = 15, stock = 20},
            {name = "Pork", label = "Pork", price = 18, stock = 18}
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
            {name = "Ice Cream", label = "Ice Cream", price = 10, stock = 10},
            {name = "Frozen Pizza", label = "Frozen Burgers", price = 15, stock = 8},
            {name = "Frozen Vegetables", label = "Frozen Nuggets", price = 8, stock = 12}
        }
    },
    ["Drinks"] = {
        coords = vector3(-1240.1, -1455.9, 3.3),
        shopName = "Drinks",
        targetLabel = "Drinks Shop",
        boxZone = {2.5, 2.5},
        heading = 0,
        minZ = 1.3,
        maxZ = 5.3,
        icon = "fas fa-cocktail",
        items = {
            {name = "beer", label = "Beer", price = 5, stock = 20},
            {name = "whiskey", label = "Whiskey", price = 20, stock = 15},
            {name = "vodka", label = "Vodka", price = 25, stock = 10}
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
            {name = "Milk", label = "Milk", price = 3, stock = 25},
            {name = "Cheese", label = "Cheese", price = 5, stock = 20},
            {name = "Yogurt", label = "Yogurt", price = 4, stock = 18}
        }
    }
}

Config.Blip = {
    coords = vector3(-1120.73, -1363.57, 5.04),
    sprite = 52,
    color = 2,
    name = "Grocery Store"
}