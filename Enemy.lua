Mobs = {}

local Enemy = Class {__includes = Entity}

function Enemy:init(model, x, y)
    Entity.init(self, x, y, model.stats.modelWidth, model.stats.modelHeight)
    table.insert(Mobs, self)
    self.attackRate = model.stats.attackRate
    self.speed = model.stats.speed
    self.model = AnimationModel(model)
    self.cd = 0
end

function Enemy:update(dt)
    local animationComplete = self.model.animationComplete

    -- movement logic
    local ds = self.speed * dt
    local hMov, vMov, movDirection = dir8('w', 's', 'a', 'd')
    self.x = coerce(self.x + hMov * ds, 0, GAME_WIDTH - self.width)
    self.y = coerce(self.y + vMov * ds, 0, GAME_HEIGHT - self.height)
    Entity.update(self)

    -- fire logic
    self.cd = self.cd - dt
    local hAim, vAim, aimDirection = dir8('up', 'down', 'left', 'right')
    if self.cd <= 0 and #aimDirection > 0 then
            self.cd = self.attackRate
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

function Enemy:draw() self.model:draw(self.x, self.y) end

return Enemy