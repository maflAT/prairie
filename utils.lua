-- global utility and helper functions

-- return x / y 'vector' as one of 8 directions based on 4 direction keys
local invSqr2 = 1 / math.sqrt(2)
function dir8(upKey, downKey, leftKey, rightKey)
    local x, y, h = 0.0, 0.0, ''
    if love.keyboard.isDown(upKey)    then y = -1    end
    if love.keyboard.isDown(downKey)  then y = y + 1 end
    if love.keyboard.isDown(leftKey)  then x = -1    end
    if love.keyboard.isDown(rightKey) then x = x + 1 end

    if x ~= 0 and y ~= 0 then x = x * invSqr2; y = y * invSqr2 end
    if y < 0 then h = 'north' elseif y > 0 then h = 'south' end
    if x < 0 then h = h..'west' elseif x > 0 then h = h..'east' end
    return x, y, h
end

-- generate quads from atlas
function generateQuads(atlas, tileWidth, tileHeight)
    local atlasWidth, atlasHeight = atlas:getDimensions()
    local quads = {}
    local i = 1
    for y = 0, atlasHeight - tileHeight, tileHeight do
        for x = 0, atlasWidth - tileWidth, tileWidth do
            quads[i] = love.graphics.newQuad(
                x, y, tileWidth, tileHeight, atlasWidth, atlasHeight)
            i = i + 1
        end
    end
    return quads
end

-- limit value to lower and upper bounds
function coerce(n, min, max) return math.max(min, math.min(n, max)) end

-- round to nearest integer
function round(n) return math.floor(n + 0.5) end

-- simple collision detection using left, right, top, bottom edges
function overlaps(a, b)
    if (a.ri < b.le) or (b.ri < a.le) or (a.bot < b.top) or (b.bot < a.top) then
        return false    -- no overlap on any axis
    else
        return true
    end
end

-- remove all entities from list, that are marked for deletion
function cleanUp(...)
    for i = 1, select('#', ...) do
        local killList = {}
        for k, entity in pairs(select(i, ...)) do
            if entity.delete then table.insert(killList, k) end
        end
        for _, entity in pairs(killList) do select(i, ...)[entity] = nil end
    end
end

-- display various debug information
debugText = Class {
    init = function(self)
        self.enabled = true
    end,
    toggle = function(self)
        self.enabled = not self.enabled
    end,
    draw = function(self, map, player)
        if self.enabled then
            local r, g, b, a = love.graphics.getColor()
            love.graphics.setColor(0, 0.8, 0, 0.7)
            love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 0, 0)
            love.graphics.print('Bullets: ' .. #Bullets, 0, 8)
            love.graphics.print('State: ' .. player.model.doing, 0, 16)
            love.graphics.print('Frame: ' .. player.model.animation.currentFrame, 0, 24)
            love.graphics.print('Life: ' .. player.life, 0, 32)
            love.graphics.setColor(r, g, b, a)
        end
    end,
} ()