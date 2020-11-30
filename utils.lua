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

-- simple fps counter
function displayFPS()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 1, 0, 0.6)
    love.graphics.print(tostring(love.timer.getFPS()), 4, 4)
    love.graphics.setColor(r, g, b, a)
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