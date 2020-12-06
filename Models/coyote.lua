-- descripition of graphics and sound data for the player model

local defaults = {
    sprites = {
        file = "",
        tileWidth = 70,
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
        xOffset = 12,
        yOffset = 16,
    },
}

local stats = {
    attackRate = 1,     -- in seconds
    speed = 80,         -- in pixel / sec
    modelWidth = 24,
    modelHeight = 32,
}

local sprites = {
    [1] = {file = "/assets/Graphics/Mobs/Coyote/Coyote Front Sheet.png"},
    [2] = {file = "/assets/Graphics/Mobs/Coyote/Coyote Back Sheet.png"},
    [3] = {file = "/assets/Graphics/Mobs/Coyote/Coyote Side Sheet.png"},
}

local behaviours = {
    idle = {
        frames = {1, 2, 3, 4, 5, 6, 7},
        updateRate = 1 / 6,
    },
    walking = {
        frames = {25,26,27,28,29,30,31,32,33,34,35,36,37,38},
        updateRate = 1 / 10,
    },
    attacking = {
        frames = {49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71},
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
        xOffset = 36,
    },
}

local function attackPattern(self, dt)
    -- move towards player
    local dx = self.player.x - self.x
    local dy = self.player.y - self.y
    local dx2 = dx ^ 2
    local dy2 = dy ^ 2
    local hyp = dx2 + dy2
    if hyp > 100 then
        local hMov, vMov = 0, 0
        if dx2 < dy2 then
            vMov = self.speed * dt * (dy < 0 and -1 or 1)
        else
            hMov = self.speed * dt * (dx < 0 and -1 or 1)
        end
        self.x = coerce(self.x + hMov, 0, GAME_WIDTH - self.width)
        self.y = coerce(self.y + vMov, 0, GAME_HEIGHT - self.height)
    end

    -- determine correct orientation
    local behaviour, orientation
    if dx2 < dy2 then
        orientation = dy < 0 and 'north' or 'south'
    else
        orientation = dx < 0 and 'west' or 'east'
    end

    -- play attack animation if within certain range
    if hyp < 5000 then behaviour = 'attacking' else behaviour = 'walking' end

    return behaviour, orientation
end

return {
    defaults = defaults,
    stats = stats,
    sprites = sprites,
    behaviours = behaviours,
    orientations= orientations,
    attackPattern = attackPattern,
}