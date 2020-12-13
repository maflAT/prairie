-- descripition of graphics and sound data for the player model

local defaults = {
    sprites = {
        file = "",
        tileWidth = 48,
        tileHeight = 44,
    },
    behaviours = {
        frames = {},
        updateRate = 1 / 15,
    },
    orientations = {
        sprites = 1,
        xScale = 1,
        yScale = 1,
        xOffset = 15,
        yOffset = 16,
    },
}

local stats = {
    attackRate = 0.3,   -- in seconds
    moveSpeed = 120,        -- in pixel / sec
    modelWidth = 16,
    modelHeight = 24,
    hitPoints = 3,
    invincibilityTime = 1,   -- invincibility time after getting hit [s]
}

local sprites = {
    [1] = {file = "/assets/Graphics/Player/Player Front Sheet.png",
        --    tileWidth = 48,
        --    tileHeight = 44
        },
    [2] = {file = "/assets/Graphics/Player/Player Back Sheet.png"},
    [3] = {file = "/assets/Graphics/Player/Player Side Sheet.png"},
    [4] = {file = "/assets/Graphics/Player/Player Angle 1 Sheet.png"},
    [5] = {file = "/assets/Graphics/Player/Player Angle 2 Sheet.png"},
}

local behaviours = {
    idle = {
        frames = {1, 2, 3, 4, 5, 6},
        updateRate = 1 / 6,
    },
    walking = {
        frames = {15, 16, 17, 18, 19, 20, 21, 22},
        updateRate = 1 / 10,
    },
    attacking = {
        frames = {29, 30, 31, 32, 33, 34},
        updateRate = 1 / 30,
    },
    harm = {
        frames = {43},
        updateRate = 1 / 6,
    },
    die = {
        frames = {57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70},
        -- updateRate =
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
        xOffset = 31,
    },
    southeast = {
        sprites = 4,
    },
    southwest = {
        sprites = 4,
        xScale = -1,
        xOffset = 31,
    },
    northeast = {
        sprites = 5,
    },
    northwest = {
        sprites = 5,
        xScale = -1,
        xOffset = 31,
    },
}

return {
    defaults = defaults,
    stats = stats,
    sprites = sprites,
    behaviours = behaviours,
    orientations= orientations,
}