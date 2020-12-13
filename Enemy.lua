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
    self.hurtCD = 0
    self.dying = false
    self.attackSound = model.sounds.attack:clone()
    self.hitSound = model.sounds.hit:clone()
end

function Enemy:update(dt)
    if self.dying then
        local done = self.model:update(dt)
        if done then self:kill() end
        return
    end

    if self.hurtCD > 0 then self.hurtCD = math.max(0, self.hurtCD - dt) end

    local behaviour, orientation = self:attackPattern(dt)
    self.model:doo(behaviour)
    self.model:face(orientation)
    Entity.update(self)

    -- hit detection against player
    if overlaps(self.boundingBox, self.player.boundingBox) then
        self.player:hit(1)
    end

    self.model:update(dt)
end

function Enemy:hit(damage)
    if self.hurtCD > 0 then return end
    self.hp = self.hp - damage
    self.hitSound:stop()
    self.hitSound:play()
    if self.hp > 0 then
        self.hurtCD = self.iTime
        self.model:doo('harm')
    else
        self.dying = true
        self.model:doOnce('die')
    end
end

function Enemy:draw()
    if self.hurtCD > 0 or self.dying then
        -- blink player by skipping some draw calls
        if math.floor(love.timer.getTime()*10) % 2 == 0 then return end
    end
    self.model:draw(self.x, self.y)
end

return Enemy