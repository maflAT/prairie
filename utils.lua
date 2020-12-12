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

-- convert cardinal directions in string format to X/Y in -1 / +1 range
function cardinaltoXY(cardinal)
    if cardinal == '' then return 0, 0 end
    local c = string.lower(string.sub(cardinal, 1, 1))
    if c == 'e' then return  1,  0 end
    if c == 'w' then return -1,  0 end
    if c == 's' then return  0,  1 end
    if c == 'n' then return  0, -1 end
    return nil
end

-- pick a random element of a list/table
function pick(list)
    -- create an index of the lists keys
    local index = {}
    for key, _ in pairs(list) do
        table.insert(index, key)
    end
    return list[index[math.random(#index)]]
end

-- return the lenth of a list/table by counting each entry
function len(list)
    local len = 0
    for _, _ in pairs(list) do len = len + 1 end
    return len
end

-- apply function to all arguments
function doAll(f, ...)
    assert(type(f) == 'function')
    for i = 1, select('#', ...) do f(select(i, ...)) end
end
