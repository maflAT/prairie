BULLET_SPEED = 300  --in pixel/sec
BULLET_DAMAGE = 1
gBullets = {}

local Projectile = Class {__includes = Entity}

function Projectile:init(x, y, vx, vy, hostile, targets)
    Entity.init(self, x, y, 4, 4, 12)
    table.insert(gBullets, self)
    if hostile then
        self.targets = targets
    else
        self.targets = gMobs
    end
    self.vx = vx * BULLET_SPEED
    self.vy = vy * BULLET_SPEED
end

function Projectile:update(dt)
    -- update position
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    Entity.update(self)
    if self.x < 0 or self.x > GAME_WIDTH or self.y < 0 or self.y > GAME_HEIGHT then
        self:kill() -- delete projectile if it's outside of the map
    end

    -- hit detection against Enemies
    for _, target in pairs(self.targets) do
        if overlaps(self.boundingBox, target.boundingBox) then
            target:hit(BULLET_DAMAGE)
            self:kill()
            break
        end
    end
end

function Projectile:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', self.x - 1, self.y - 1, 2, 2)
    love.graphics.setColor(0.25, 0.25, 0.4, 1)
    love.graphics.rectangle('line', self.x - 2, self.y - 2, 4, 4, 1)
    love.graphics.setColor(r, g, b, a)
end

return Projectile