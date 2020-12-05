local fireRate = 0.3    -- in seconds
local playerSpeed = 120 -- in pixel / sec
local playerWidth = 16
local playerHeight = 24

return Class {__includes = Entity,

    init = function(self, x, y)
        Entity.init(self, x, y)
        self.cd = 0
        self.speed = playerSpeed
        self.width = playerWidth
        self.height = playerHeight
        self.model = require 'Model' (require '/models/player')
    end,

    update = function(self, dt)
        local animationComplete = self.model.animationComplete

        -- movement logic
        local ds = self.speed * dt
        local hMov, vMov, movDirection = dir8('w', 's', 'a', 'd')
        self.x = coerce(self.x + hMov * ds, 0, GAME_WIDTH - self.width)
        self.y = coerce(self.y + vMov * ds, 0, GAME_HEIGHT - self.height)
        
        -- fire logic
        self.cd = self.cd - dt
        local hAim, vAim, aimDirection = dir8('up', 'down', 'left', 'right')
        if self.cd <= 0 and #aimDirection > 0 then
                self.cd = fireRate
                local bullet = Projectile(self.x, self.y, hAim, vAim)
                table.insert(Bullets, #Bullets + 1, bullet)
                self.model:doo('shooting')
                self.model:face(aimDirection)
        elseif self.model.doing ~= 'shooting' or animationComplete then
            if #movDirection > 0 then
                self.model:doo('walking')
                self.model:face(movDirection)
            else
                self.model:doo('idle')
            end
        end
        self.model:update(dt)
    end,

    draw = function(self)
        self.model:draw(self.x, self.y)
    end
}