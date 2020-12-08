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
    local turnthreshold = math.min(self.width / 2, self.height / 2)
    local direction = self.model.facing
    local dx = self.player.x - self.x
    local dy = self.player.y - self.y

    -- play attack animation if within certain range
    local behaviour = dx^2 + dy^2 < 5000 and 'attacking' or 'walking'

    -- move towards player
    if math.abs(dx) > turnthreshold or math.abs(dy) > turnthreshold then

        -- if currently facing towards player and sufficiently far away,
        if     dx >  turnthreshold and direction == 'east'  then -- keep direction
        elseif dx < -turnthreshold and direction == 'west'  then
        elseif dy >  turnthreshold and direction == 'south' then
        elseif dy < -turnthreshold and direction == 'north' then

            -- if still outside of threshold area, turn towards player
        else
            if math.abs(dx) < math.abs(dy) then
                direction = dy < 0 and 'north' or 'south'
            else
                direction = dx < 0 and 'west' or 'east'
            end
        end
        dx, dy = cardinaltoXY(direction)
        self.x = coerce(self.x + dx * self.speed * dt, 0, GAME_WIDTH - self.width)
        self.y = coerce(self.y + dy * self.speed * dt, 0, GAME_HEIGHT - self.height)
    end
    return behaviour, direction
end

return {
    defaults = defaults,
    stats = stats,
    sprites = sprites,
    behaviours = behaviours,
    orientations = orientations,
    attackPattern = attackPattern,
}