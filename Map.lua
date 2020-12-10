
local Map = Class{player = {}}

local Enemy = require 'Enemy'
local charData = {
    Cactus = require '/models/cactus',
    Coffin = require '/models/coffin',
    Coyote = require '/models/coyote',
}
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

function Map:init(player)
    Map.player = player
    self.spawntimer = 0
    self.width = math.ceil(GAME_WIDTH / tileWidth)
    self.height = math.ceil(GAME_HEIGHT / tileHeight)
    fill(self, self.width, self.height)

    Enemy.map = self
    Enemy.player = player
end

function Map:update(dt)
    self.player:update(dt)
    for _, mob in pairs(Mobs) do mob:update(dt) end
    for _, bullet in pairs(Bullets) do bullet:update(dt) end

    self.spawntimer = self.spawntimer - dt
    if self.spawntimer <= 0 then
        self.spawntimer = 2
        local mobs = {'Coffin', 'Cactus', 'Coyote'}
        self:spawnMob(mobs[math.random(3)])
    end
end

function Map:spawnMob(mob)
    local model = charData[mob]
    local xRange = math.random(0, GAME_WIDTH - model.stats.modelWidth)
    local yRange = math.random(0, GAME_HEIGHT - model.stats.modelHeight)
    local edges = {
        [1] = function () return xRange, 0 - model.stats.modelHeight end,
        [2] = function () return xRange, GAME_HEIGHT end,
        [3] = function () return 0 - model.stats.modelWidth, yRange end,
        [4] = function () return GAME_WIDTH, yRange end,
    }
    Enemy(model, edges[math.random(4)]())
end

function Map:draw()
    for y = 0, self.height - 1 do
        for x = 0, self.width - 1 do
            love.graphics.draw(atlas, quads[self[y][x]], x * tileWidth, y * tileHeight)
        end
    end
end

return Map