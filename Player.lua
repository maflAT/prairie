
local Player = Class {__includes = Entity}

function Player:init(model, x, y)
    Entity.init(self, x, y, model.stats.modelWidth, model.stats.modelHeight)
    self.attackRate = model.stats.attackRate
    self.speed = model.stats.speed
    self.model = AnimationModel(model)
    self.attackCD = 0
    self.life = 3
    self.invincible = 0
end

function Player:update(dt)
    local animationComplete = self.model.animationComplete
    
    -- get user input
    local hMov, vMov, movDirection = dir8('w', 's', 'a', 'd')
    local hAim, vAim, aimDirection = dir8('up', 'down', 'left', 'right')
    
    -- update position
    local ds = self.speed * dt
    self.x = coerce(self.x + hMov * ds, 0, GAME_WIDTH - self.width)
    self.y = coerce(self.y + vMov * ds, 0, GAME_HEIGHT - self.height)
    Entity.update(self)

    -- hit detection against Enemies
    if self.invincible <= 0 then
        for _, mob in pairs(Mobs) do
            if overlaps(self.boundingBox, mob.boundingBox) then
                self.life = self.life - 1
                self.invincible = 2
            end
        end
    else
        self.invincible = math.max(0, self.invincible - dt)
    end

    -- fire logic
    self.attackCD = self.attackCD - dt
    if self.attackCD <= 0 and #aimDirection > 0 then
            self.attackCD = self.attackRate
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