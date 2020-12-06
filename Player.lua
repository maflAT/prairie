
local Player = Class {__includes = Entity}

function Player:init(model, x, y)
    Entity.init(self, x, y, model.stats.modelWidth, model.stats.modelHeight)
    self.attackRate = model.stats.attackRate
    self.speed = model.stats.speed
    self.model = AnimationModel(model)
    self.cd = 0
end

function Player:update(dt)
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
            self.cd = self.attackRate
            Projectile(self.x, self.y, hAim, vAim)
            self.model:doo('attacking')
            self.model:face(aimDirection)
    elseif self.model.doing ~= 'attacking' or animationComplete then
        if #movDirection > 0 then
            self.model:doo('walking')
            self.model:face(movDirection)
        else
            self.model:doo('idle')
        end
    end
    self.model:update(dt)
end

function Player:draw() self.model:draw(self.x, self.y) end

return Player