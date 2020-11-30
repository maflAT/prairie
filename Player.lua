local fireRate = 0.2    -- in rounds / sec
local playerSpeed = 150 -- in pixel / sec
local playerWidth = 16
local playerHeight = 24

local Model = require 'Model'

return Class {__includes = Entity,

    init = function(self, x, y)
        Entity.init(self, x, y)
        self.cd = 0
        self.speed = playerSpeed
        self.width = playerWidth
        self.height = playerHeight
        self.model = Model(require('/models/player'))
        -- self.model:setState('walking', 'east')
    end,

    update = function(self, dt)
        -- movement logic
        local ds = self.speed * dt
        local dirX, dirY, heading = dir8('w', 's', 'a', 'd')
        self.x = coerce(self.x + dirX * ds, 0, GAME_WIDTH - self.width)
        self.y = coerce(self.y + dirY * ds, 0, GAME_HEIGHT - self.height)
        if not self.model.state == 'shooting' then
            self.model:setState('walking', heading)
        end
        
        -- fire logic
        self.cd = self.cd - dt
        local hAim, vAim, aim = dir8('up', 'down', 'left', 'right')
        if self.cd <= 0 then
            if hAim ~= 0 or vAim ~= 0 then
                self.cd = fireRate
                local bullet = Projectile(self.x, self.y, hAim, vAim)
                table.insert(Bullets, #Bullets + 1, bullet)
                self.model:setState('shooting', aim)
            end
        end
        if self.model:update(dt) and aim == '' then
            if heading ~= '' then
                self.model:setState('walking', heading)
            else
                self.model:setState('idle', heading)
            end
        end
    end,

    draw = function(self)
        self.model:draw(self.x, self.y)
    end
}