local fireRate = 0.2    -- in rounds / sec
local playerSpeed = 150 -- in pixel / sec
local playerWidth = 16
local playerHeight = 24

local spriteSheet = love.graphics.newImage('/assets/Graphics/Player/Player Front Sheet.png')
local tileWidth = 48
local tileHeight = 48
local quads = generateQuads(spriteSheet, tileWidth, tileHeight)

local tiles = {1, 2, 3, 4, 5, 6}

local Animation = require 'Animation'

return Class {__includes = Entity,

    init = function(self, x, y)
        Entity.init(self, x, y)
        -- self.fireRate = fireRate
        self.cd = 0
        self.speed = playerSpeed
        self.width = playerWidth
        self.height = playerHeight
        self.animation = Animation(tiles, 1 / 6)
    end,

    update = function(self, dt)
        -- movement logic
        local ds = self.speed * dt
        local dirX, dirY = dir8('w', 's', 'a', 'd')
        self.x = coerce(self.x + dirX * ds, 0, GAME_WIDTH - self.width)
        self.y = coerce(self.y + dirY * ds, 0, GAME_HEIGHT - self.height)
        self.animation:update(dt)

        -- fire logic
        self.cd = self.cd - dt
        if self.cd <= 0 then
            local hAim, vAim = dir8('up', 'down', 'left', 'right')
            if hAim ~= 0 or vAim ~= 0 then
                self.cd = fireRate
                local bullet = Projectile(self.x, self.y, hAim, vAim)
                table.insert(Bullets, #Bullets + 1, bullet)
            end
        end
    end,

    draw = function(self)
        local quad = self.animation:draw()
        love.graphics.draw(spriteSheet, quads[quad], round(self.x), round(self.y),
            0, 1, 1, 15, 16)
    end
}