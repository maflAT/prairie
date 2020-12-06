Mobs = {}

local Enemy = Class {__includes = Entity, map = {}, player = {}}

function Enemy:init(model, x, y)
    Entity.init(self, x, y, model.stats.modelWidth, model.stats.modelHeight)
    table.insert(Mobs, self)
    self.attackRate = model.stats.attackRate
    self.speed = model.stats.speed
    self.model = AnimationModel(model)
    self.cd = 0
end

function Enemy:update(dt)

    -- move towards player
    local dx = self.player.x - self.x
    local dy = self.player.y - self.y
    local dx2 = dx ^ 2
    local dy2 = dy ^ 2
    local hyp = dx2 + dy2
    if hyp > 100 then
        local ds = self.speed * dt / hyp
        local hMov = dx2 * ds * (dx < 0 and -1 or 1)
        local vMov = dy2 * ds * (dy < 0 and -1 or 1)
        self.x = coerce(self.x + hMov, 0, GAME_WIDTH - self.width)
        self.y = coerce(self.y + vMov, 0, GAME_HEIGHT - self.height)
    end

    -- determine correct orientation
    if dx2 < dy2 then
        self.model:face(dy < 0 and 'north' or 'south')
    else
        self.model:face(dx < 0 and 'west' or 'east')
    end

    -- play attack animation if within certain range
    if hyp < 5000 then
        self.model:doo('attacking')
    else
        self.model:doo('walking')
    end

    Entity.update(self)
    self.model:update(dt)
end

function Enemy:draw() self.model:draw(self.x, self.y) end

return Enemy