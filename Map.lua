
Map = Class{}

local atlas = love.graphics.newImage('assets/graphics/Atlas.png')
local tileWidth = 16
local tileHeight = 16
local quads = generateQuads(atlas, tileWidth, tileHeight)
local tiles = {
    desert = {
        lowGround = {
            plain = 1808,
            topLeft = 1757,
            topEdge = 1759,
            topRight = 1760,
            leftEdge = 1807,
            rightEdge = 1810,
            bottomLeft = 1910,
            bottomEdge = 1912,
            bottomRight = 1913,
            highlights = {1858, 1729, 1732, 1779, 1780, 1830,}
        }
    }
}


local function fill(tileGrid, width, height)
    local tileSet = tiles.desert.lowGround.highlights
    for y = 0, height - 1 do
        tileGrid[y] = {}
        for x = 0, width - 1 do
            tileGrid[y][x] = tileSet[math.random(#tileSet * 4)] or tiles.desert.lowGround.plain
        end
    end
end


function Map:init()
    self.width = GAME_WIDTH / tileWidth
    self.height = GAME_HEIGHT / tileHeight
    fill(self, self.width, self.height)
end

function Map:draw()
    for y = 0, self.height - 1 do
        for x = 0, self.width - 1 do
            love.graphics.draw(atlas, quads[self[y][x]], x * tileWidth, y * tileHeight)
        end
    end
end

return Map