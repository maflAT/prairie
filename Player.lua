
local Player = Class {__includes = Entity}

function Player:init(model)
    Entity.init(self, 0, 0, model.stats.modelWidth, model.stats.modelHeight)
    self.model = AnimationModel(model)
    self.defaultStats = model.stats
    self:reset()
end

function Player:reset(x, y)
    self.x = x or (GAME_WIDTH - self.width) / 2
    self.y = y or (GAME_HEIGHT - self.height) / 2
    self.hp = self.defaultStats.hitPoints
    self.speed = self.defaultStats.moveSpeed
    self.attackRate = self.defaultStats.attackRate
    self.attackCD = 0
    -- invincibility time after getting hit
    self.iTime = self.defaultStats.invincibilityTime
    self.hitCD = 0
    self.model:doo('idle')
    self.model:face('south')
    Entity.update(self)
end

function Player:update(dt)

    -- get user input
    local hMov, vMov, movDirection = dir8('w', 's', 'a', 'd')
    local hAim, vAim, aimDirection = dir8('up', 'down', 'left', 'right')

    -- update position
    local ds = self.speed * dt
    self.x = coerce(self.x + hMov * ds, 0, GAME_WIDTH - self.width)
    self.y = coerce(self.y + vMov * ds, 0, GAME_HEIGHT - self.height)
    Entity.update(self)

    -- hit detection against touching enemies
    if self.hitCD > 0 then
        self.hitCD = math.max(0, self.hitCD - dt)
    else
        for _, mob in pairs(gMobs) do
            if overlaps(self.boundingBox, mob.boundingBox) then
                self:hit(1)
                break
            end
        end
    end

    -- player state transitions
    self.attackCD = self.attackCD - dt
    local finished = self.model.animationComplete
    local animation = self.model.doing
    local orientation = self.model.facing

    if finished then animation = 'idle' end

    if animation == 'harm' then
        -- stay in 'harm'
    elseif #aimDirection > 0 and self.attackCD <= 0 then
        self.attackCD = self.attackRate
        Projectile(self.x, self.y, hAim, vAim)
        animation, orientation = 'attacking', aimDirection
    elseif #movDirection > 0 and animation ~= 'attacking' then
        animation, orientation = 'walking', movDirection
    end
    self.model:doo(animation)
    self.model:face(orientation)
    self.model:update(dt)
end

function Player:hit(damage)
    if self.hitCD <= 0 then
        self.hitCD = self.iTime
        self.hp = self.hp - damage
        if self.hp <= 0 then
            gGameState = 'gameover'
            self.model:doo('dying')
        else
            self.model:doo('harm')
        end
    end
end

function Player:draw() self.model:draw(self.x, self.y) end

return Player