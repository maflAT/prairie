-- desctripition of graphics and sound data for the player model
local playerModel = {
    sprites = {
        [1] = {file = "/assets/Graphics/Player/Player Front Sheet.png",
                 tileWidth = 48, tileHeight = 48},
        [2] = {file = "/assets/Graphics/Player/Player Back Sheet.png",
                 tileWidth = 48, tileHeight = 48},
        [3] = {file = "/assets/Graphics/Player/Player Side Sheet.png",
                 tileWidth = 48, tileHeight = 48},
    },
    states = {
        idle = {
            south = {
                sprites = 1,
                frames = {1, 2, 3, 4, 5, 6},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
            north = {
                sprites = 2,
                frames = {1, 2, 3, 4, 5, 6},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
            east = {
                sprites = 3,
                frames = {1, 2, 3, 4, 5, 6},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
        },

        walking = {
            south = {
                sprites = 1,
                frames = {15, 16, 17, 18, 19, 20, 21, 22},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
            north = {
                sprites = 2,
                frames = {15, 16, 17, 18, 19, 20, 21, 22},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
            east = {
                sprites = 3,
                frames = {15, 16, 17, 18, 19, 20, 21, 22},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
        },

        shooting = {
            south = {
                sprites = 1,
                frames = {29, 30, 31, 32, 33, 34},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
            north = {
                sprites = 2,
                frames = {29, 30, 31, 32, 33, 34},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
            east = {
                sprites = 3,
                frames = {29, 30, 31, 32, 33, 34},
                updateRate = 1 / 6,
                tileWidth = 48,
                tileHeight = 48,
                xOffset = 15,
                yOffset = 16,
            },
        },
    },
}
return playerModel