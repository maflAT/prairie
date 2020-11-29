local atlas = love.graphics.newImage('assets/graphics/Atlas.png')
local atlasWidth, atlasHeight = atlas:getDimensions()
local tileWidth = 16
local tileHeight = 16

local tiles = {
    desert = {
        lowGround = {
            topLeft = 1757,
            topEdge = 1759,
            topRight = 1760,
            leftEdge = 1807,
            rightEdge = 1810,
            bottomLeft = 1910,
            bottomEdge = 1912,
            bottomRight = 1913,
            plain = {1808, 1809, 1858, 1859, 1729, 1730, 1731, 1732, 
                1779, 1780, 1781, 1782, 1829, 1830, 1831, 1732}
        }
    }
}

local quads = {}
for y = 0, atlasHeight - tileHeight, tileHeight do
    for x = 0, atlasWidth - tileWidth, tileWidth do
        table.insert(quads, #quads + 1, love.graphics.newQuad(
            x, y, tileWidth, tileHeight, atlasWidth, atlasHeight))
    end
end

local function fill(map, width, height)
    for y = 0, height - 1 do
        map[y] = {}
        for x = 0, width - 1 do
            map[y][x] = tiles.desert.lowGround.plain[math.random(#tiles.desert.lowGround.plain)]
        end
    end
end

return Class{

init = function (self)
    self.width = GAME_WIDTH / tileWidth
    self.height = GAME_HEIGHT / tileHeight
    fill(self, self.width, self.height)
end,

draw = function (self)
    for y = 0, self.height - 1 do
        for x = 0, self.width - 1 do
            love.graphics.draw(atlas, quads[self[y][x]], x * tileWidth, y * tileHeight)
        end
    end
end
}