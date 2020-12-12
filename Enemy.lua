gMobs = {}

local Enemy = Class {__includes = Entity, map = {}, player = {}}

function Enemy:init(model, x, y)
    Entity.init(self, x, y, model.stats.modelWidth, model.stats.modelHeight)
    table.insert(gMobs, self)
    self.model = AnimationModel(model)
    self.attackPattern = model.attackPattern

    self.speed = model.stats.moveSpeed
    self.hp = model.stats.hitPoints
    self.attackRate = model.stats.attackRate
    self.attackCD = 0

    -- invincibility time after getting hit
    self.iTime = model.stats.invincibilityTime
    self.hitCD = 0
end

function Enemy:update(dt)
    if self.hitCD > 0 then self.hitCD = math.max(0, self.hitCD - dt) end

    local behaviour, orientation = self:attackPattern(dt)
    Entity.update(self)
    self.model:doo(behaviour)
    self.model:face(orientation)
    self.model:update(dt)
end

function Enemy:hit(damage)
    if self.hitCD <= 0 then
        self.hp = self.hp - damage
        self.hitCD = self.iTime
    end
    if self.hp <= 0 then self:kill() end
end

function Enemy:draw() self.model:draw(self.x, self.y) end

return Enemy