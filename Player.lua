
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
    self.hurtCD = 0
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

    -- update cooldowns / timeouts
    self.hurtCD = math.max(0, self.hurtCD - dt)
    self.attackCD = math.max(0, self.attackCD - dt)

    -- player state transitions
    local finished = self.model.animationComplete
    local action = self.model.doing
    local orientation = self.model.facing

    if finished then action = 'idle' end

    if action == 'harm' then
        -- stay in 'harm'
    elseif #aimDirection > 0 and self.attackCD <= 0 then
        self.attackCD = self.attackRate
        Projectile(self.x, self.y, hAim, vAim)
        action, orientation = 'attacking', aimDirection
    elseif action ~= 'attacking' then
        if #movDirection > 0 then
            action, orientation = 'walking', movDirection
        else
            action = 'idle'
        end
    end
    self.model:doo(action)
    self.model:face(orientation)
    self.model:update(dt)
end

function Player:hit(damage)
    if self.hurtCD > 0 then return end
    self.hp = self.hp - damage
    if self.hp > 0 then
        self.hurtCD = self.iTime
        self.model:doo('harm')
    else
        gGameState = 'gameover'
        self.model:doOnce('die')
    end
end

function Player:draw()
    if self.hurtCD > 0 then
        -- blink player by skipping some draw calls
        if math.floor(love.timer.getTime()*10) % 2 == 0 then return end
    end
    self.model:draw(self.x, self.y)
end

return Player