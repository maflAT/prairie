-- descripition of graphics and sound data for the player model

local defaults = {
    sprites = {
        file = "",
        tileWidth = 40,
        tileHeight = 40,
    },
    behaviours = {
        frames = {},
        updateRate = 1 / 15,
    },
    orientations = {
        sprites = 1,
        xScale = 1,
        yScale = 1,
        xOffset = 12,
        yOffset = 17,
    },
}

local stats = {
    attackRate = 1,     -- in seconds
    speed = 80,         -- in pixel / sec
    modelWidth = 16,
    modelHeight = 22,
}

local sprites = {
    [1] = {file = "/assets/Graphics/Mobs/Cactus/Cactus Front Sheet.png",
        --    tileWidth = 48,
        --    tileHeight = 44
        },
    [2] = {file = "/assets/Graphics/Mobs/Cactus/Cactus Back Sheet.png"},
    [3] = {file = "/assets/Graphics/Mobs/Cactus/Cactus Side Sheet.png"},
}

local behaviours = {
    idle = {
        frames = {1, 2, 3, 4},
        updateRate = 1 / 6,
    },
    walking = {
        frames = {12, 13, 14, 15, 16, 17, 18, 19, 20},
        updateRate = 1 / 10,
    },
    attacking = {
        frames = {23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33},
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
        xOffset = 28,
    },
}

return {
    defaults = defaults,
    stats = stats,
    sprites = sprites,
    behaviours = behaviours,
    orientations= orientations,
}