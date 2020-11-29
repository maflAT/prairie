local atlas = love.graphics.newImage('assets/graphics/Atlas.png')
local tileWidth = 16
local tileHeight = 16
local quads = generateQuads(atlas, tileWidth, tileHeight)

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

local function fill(map, width, height)
    local tileSet = tiles.desert.lowGround.plain
    for y = 0, height - 1 do
        map[y] = {}
        for x = 0, width - 1 do
            map[y][x] = tileSet[math.random(#tileSet)]
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