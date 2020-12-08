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
        yOffset = 9,
    },
    behaviour = 'walking'
}

local stats = {
    attackRate = 1,     -- in seconds
    speed = 80,         -- in pixel / sec
    modelWidth = 16,
    modelHeight = 30,
}

local sprites = {
    [1] = {file = "/assets/Graphics/Mobs/Cactus/Cactus Front Sheet.png"},
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

local MARGIN = 10
local ATTACK_DELAY = 0.2
local function attackPattern(self, dt)

    local behaviour, direction = self.model.doing, ''
    -- spawn at edge and move away from it
    if behaviour == 'walking' then
        if self.x < MARGIN then
            behaviour, direction = 'walking', 'east'
        elseif self.x > GAME_WIDTH - self.width - MARGIN then
            behaviour, direction = 'walking', 'west'
        elseif self.y < MARGIN then
            behaviour, direction = 'walking', 'south'
        elseif self.y > GAME_HEIGHT - self.height - MARGIN then
            behaviour, direction = 'walking', 'north'
        else
            behaviour = 'idle'
        end

        local dx, dy = cardinaltoXY(direction)
        self.x = self.x + dx * self.speed * dt
        self.y = self.y + dy * self.speed * dt

    -- idle till CD wears off / start attack animation
    elseif behaviour == 'idle' then
        self.attackCD = math.max(0, self.attackCD - dt)
        if self.attackCD <= ATTACK_DELAY then
            behaviour = 'attacking'
        end

    -- shoot towards player / transition to idle after animation is done
    elseif behaviour == 'attacking' then
        self.attackCD = math.max(0, self.attackCD - dt)
        if self.attackCD <= 0 then
            local dx = (self.player.x + 8) - (self.x + 8)
            local dy = (self.player.y + 10) - (self.y + 20)
            local dx2, dy2 = dx^2, dy^2
            local vx = math.sqrt(dx2 / (dx2 + dy2))
            vx = vx * (dx < 0 and -1 or 1)
            local vy = math.sqrt(dy2 / (dx2 + dy2))
            vy = vy * (dy < 0 and -1 or 1)
            Projectile(self.x + 8, self.y + 20, vx, vy, true, {self.player})
            self.attackCD = self.attackRate
        end
        if self.model.animationComplete then
            behaviour = 'idle'
        end
    end

    return behaviour, direction
end

return {
    defaults = defaults,
    stats = stats,
    sprites = sprites,
    behaviours = behaviours,
    orientations= orientations,
    attackPattern = attackPattern,
}