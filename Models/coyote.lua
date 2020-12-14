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
    moveSpeed = 80,         -- in pixel / sec
    modelWidth = 24,
    modelHeight = 32,
    hitPoints = 2,
    invincibilityTime = 0.5,   -- invincibility time after getting hit [s]
}

local sprites = {
    [1] = {file = "/assets/graphics/Mobs/Coyote/Coyote Front Sheet.png"},
    [2] = {file = "/assets/graphics/Mobs/Coyote/Coyote Back Sheet.png"},
    [3] = {file = "/assets/graphics/Mobs/Coyote/Coyote Side Sheet.png"},
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
        frames = {49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72},
        updateRate = 1 / 30,
    },
    harm = {
        frames = {73},
        updateRate = 1 / 6,
    },
    die = {
        frames = {73},
        updateRate = 1 / 2,
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

local sounds = {
    attack = love.audio.newSource('assets/sfx/gun2.ogg', 'static'),
    hit = love.audio.newSource('assets/sfx/hit.wav', 'static'),
}
sounds.attack:setVolume(0.2)
sounds.hit:setVolume(0.5)

local function attackPattern(self, dt)
    local ds = self.speed * dt
    -- spawn at edge and move away from it
    if self.x < 0 then
        self.x = self.x + ds
        return 'walking', 'east'
    elseif self.x > GAME_WIDTH - self.width then
        self.x = self.x - ds
        return 'walking', 'west'
    elseif self.y < 0 then
        self.y = self.y + ds
        return 'walking', 'south'
    elseif self.y > GAME_HEIGHT - self.height then
        self.y = self.y - ds
        return 'walking', 'north'
    end

    local dx = self.player.x - self.x
    local dy = self.player.y - self.y

    -- play attack animation if within certain range
    local behaviour = dx^2 + dy^2 < 2000 and 'attacking' or 'walking'

    -- move towards player
    local turnthreshold = math.min(self.width / 2, self.height / 2)
    local direction = self.model.facing
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
        self.x = self.x + dx * ds
        self.y = self.y + dy * ds
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
    sounds = sounds,
}