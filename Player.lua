local fireRate = 0.2    -- in rounds / sec
local playerSpeed = 150       -- in pixel / sec
local playerWidth = 12
local playerHeight = 20

return Class {__includes = Entity,

    init = function(self, x, y)
        Entity.init(self, x, y)
        -- self.fireRate = fireRate
        self.cd = 0
        self.speed = playerSpeed
        self.width = playerWidth
        self.height = playerHeight
    end,

    update = function(self, dt)
        -- movement logic
        local ds = self.speed * dt
        local dirX, dirY = dir8('w', 's', 'a', 'd')
        self.x = self.x + dirX * ds
        self.y = self.y + dirY * ds

        -- fire logic
        self.cd = self.cd - dt
        if self.cd <= 0 then
            local hAim, vAim = dir8('up', 'down', 'left', 'right')
            if hAim ~= 0 or vAim ~= 0 then
                self.cd = fireRate
                local bullet = Projectile(self.x, self.y, hAim, vAim)
                table.insert(Projectiles, #Projectiles + 1, bullet)
            end
        end
    end,

    draw = function(self)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    end
}