BULLET_SPEED = 400  --in pixel/sec

Bullets = {}

local Projectile = Class {__includes = Entity}

function Projectile:init(x, y, vx, vy)
    Entity.init(self, x, y, 2, 2)
    table.insert(Bullets, self)
    self.vx = vx * BULLET_SPEED
    self.vy = vy * BULLET_SPEED
end

function Projectile:update(dt)
    -- update position
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    if self.x < 0 or self.x > GAME_WIDTH or self.y < 0 or self.y > GAME_HEIGHT then
        self:kill() -- delete projectile if it's outside of the map
    end

    -- hit detection
    for _, mob in pairs(Mobs) do
        if overlaps(self:getBB(), mob:getBB()) then
            mob:kill()
            self:kill()
        end
    end
end

function Projectile:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', self.x, self.y, 2, 2)
end

return Projectile