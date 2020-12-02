-- desctripition of graphics and sound data for the player model
local playerModel = {
    sprites = {
        [1] = {file = "/assets/Graphics/Player/Player Front Sheet.png",
               tileWidth = 48, tileHeight = 44},
        [2] = {file = "/assets/Graphics/Player/Player Back Sheet.png",
               tileWidth = 48, tileHeight = 44},
        [3] = {file = "/assets/Graphics/Player/Player Side Sheet.png",
               tileWidth = 48, tileHeight = 44},
        [4] = {file = "/assets/Graphics/Player/Player Angle 1 Sheet.png",
               tileWidth = 48, tileHeight = 44},
        [5] = {file = "/assets/Graphics/Player/Player Angle 2 Sheet.png",
               tileWidth = 48, tileHeight = 44},
    },
    states = {
        idle = {
            south = {},
            north = {},
            east = {},
            west = {},
            southeast = {},
            southwest = {},
            northeast = {},
            northwest = {},
        },
        walking = {
            south = {},
            north = {},
            east = {},
            west = {},
            southeast = {},
            southwest = {},
            northeast = {},
            northwest = {},
        },
        shooting = {
            south = {},
            north = {},
            east = {},
            west = {},
            southeast = {},
            southwest = {},
            northeast = {},
            northwest = {},
        },
    },

    attributes = {
        default = {
            sprites = 1,
            frames = {},
            updateRate = 1 / 15,
            tileWidth = 48,
            tileHeight = 44,
            xScale = 1,
            yScale = 1,
            xOffset = 0,
            yOffset = 0,
        },
        idle = {
            default = {
                frames = {1, 2, 3, 4, 5, 6},
                updateRate = 1 / 6,
                xOffset = 15,
                yOffset = 16,
            },
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
        },
        walking = {
            default = {
                frames = {15, 16, 17, 18, 19, 20, 21, 22},
                updateRate = 1 / 10,
                xOffset = 15,
                yOffset = 16,
            },
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
        },
        shooting = {
            default = {
                frames = {29, 30, 31, 32, 33, 34},
                updateRate = 1 / 30,
                xOffset = 15,
                yOffset = 16,
            },
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
        },
    },
}
return playerModel