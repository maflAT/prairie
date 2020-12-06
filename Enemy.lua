Mobs = {}

local Enemy = Class {__includes = Entity, map = {}, player = {}}

function Enemy:init(model, x, y)
    Entity.init(self, x, y, model.stats.modelWidth, model.stats.modelHeight)
    table.insert(Mobs, self)
    self.attackRate = model.stats.attackRate
    self.speed = model.stats.speed
    self.attackPattern = model.attackPattern
    self.model = AnimationModel(model)
    self.cd = 0
end

function Enemy:update(dt)

    local behaviour, orientation = self:attackPattern(dt)
    Entity.update(self)
    self.model:doo(behaviour)
    self.model:face(orientation)
    self.model:update(dt)
end

function Enemy:draw() self.model:draw(self.x, self.y) end

return Enemy