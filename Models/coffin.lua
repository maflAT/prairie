-- descripition of graphics and sound data for the player model

local defaults = {
    sprites = {
        file = "",
        tileWidth = 74,
        tileHeight = 70,
    },
    behaviours = {
        frames = {},
        updateRate = 1 / 15,
    },
    orientations = {
        sprites = 1,
        xScale = 1,
        yScale = 1,
        xOffset = 18,
        yOffset = 20,
    },
}

local stats = {
    attackRate = 1,     -- in seconds
    speed = 80,         -- in pixel / sec
    modelWidth = 20,
    modelHeight = 32,
}

local sprites = {
    [1] = {file = "/assets/Graphics/Mobs/Coffin/Coffin Front Sheet.png",
        --    tileWidth = 48,
        --    tileHeight = 44
        },
    [2] = {file = "/assets/Graphics/Mobs/Coffin/Coffin Back Sheet.png"},
    [3] = {file = "/assets/Graphics/Mobs/Coffin/Coffin Side Sheet.png"},
}

local behaviours = {
    idle = {
        frames = {1, 2, 3, 4, 5, 6},
        updateRate = 1 / 6,
    },
    walking = {
        frames = {19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32},
        updateRate = 1 / 10,
    },
    attacking = {
        frames = {37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54},
        updateRate = 1 / 30,
    },
}

local orientations = {
    south = {
        sprites = 1,
    },
    north = {
        sprites = 2,
    },
    east = {
        sprites = 3,
    },
    west = {
        sprites = 3,
        xScale = -1,
        xOffset = 37,
    },
}

return {
    defaults = defaults,
    stats = stats,
    sprites = sprites,
    behaviours = behaviours,
    orientations= orientations,
}