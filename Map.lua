
local Map = Class{player = {}}
local Enemy = require 'Enemy'

Map.STAGE_TIME = 10
Map.SPAWN_TIME = 3
Map.MAX_IDLE_TIME = 0.2
Map.mobTypes = {
    Cactus = require '/Models/cactus',
    Coffin = require '/Models/coffin',
    Coyote = require '/Models/coyote'}
Map.atlas = love.graphics.newImage('assets/graphics/Atlas.png')
Map.skull = love.graphics.newQuad(208, 388, 32, 24, Map.atlas:getDimensions())
Map.tileWidth = 16
Map.tileHeight = 16
Map.quads = generateQuads(Map.atlas, Map.tileWidth, Map.tileHeight)
Map.tiles = {
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
    local tileSet = Map.tiles.desert.lowGround.highlights
    for y = 0, height - 1 do
        tileGrid[y] = {}
        for x = 0, width - 1 do
            tileGrid[y][x] = tileSet[math.random(#tileSet * 4)] or Map.tiles.desert.lowGround.plain
        end
    end
end

function Map:init(player)
    Map.player = player
    self.width = math.ceil(GAME_WIDTH / Map.tileWidth)
    self.height = math.ceil(GAME_HEIGHT / Map.tileHeight)
    fill(self, self.width, self.height)

    Enemy.map = self
    Enemy.player = player
end

function Map:reset()
    gMobs = {}
    gBullets = {}
    gEntities= {self.player}
    self.player:reset()
    self.stage = 1
    self.stageTimer = self.STAGE_TIME
    self.spawnTimer = Map.MAX_IDLE_TIME
end

function Map:update(dt)
    self.player:update(dt)
    for _, bullet in pairs(gBullets) do bullet:update(dt) end

    local mobCount = 0
    for _, mob in pairs(gMobs) do
        mob:update(dt)
        mobCount = 1
    end

    self.spawnTimer = self.spawnTimer - dt
    self.stageTimer = self.stageTimer - dt
    if self.spawnTimer > Map.MAX_IDLE_TIME and mobCount == 0 then
        self.stageTimer = self.stageTimer - (self.spawnTimer - Map.MAX_IDLE_TIME)
        self.spawnTimer = Map.MAX_IDLE_TIME
    elseif self.spawnTimer <= 0 then
        self.spawnTimer = self.spawnTimer + self.SPAWN_TIME * 0.95 ^ self.stage
        self:spawnMob(self:spawnSequence())
    end

    if self.stageTimer <= 0 then
        self:nextStage()
    end
end

function Map:spawnMob(mob)
    local xRange = math.random(0, GAME_WIDTH - mob.stats.modelWidth)
    local yRange = math.random(0, GAME_HEIGHT - mob.stats.modelHeight)
    local edges = {
        [1] = function () return xRange, 0 - mob.stats.modelHeight end,
        [2] = function () return xRange, GAME_HEIGHT end,
        [3] = function () return 0 - mob.stats.modelWidth, yRange end,
        [4] = function () return GAME_WIDTH, yRange end,}
    Enemy(mob, pick(edges)())
end

function Map:spawnSequence()
    if     self.stage == 1 then return Map.mobTypes['Coffin']
    elseif self.stage == 2 then return Map.mobTypes['Cactus']
    elseif self.stage == 3 then return Map.mobTypes['Coyote']
    else return pick(Map.mobTypes) end
end

function Map:nextStage()
    self.stage = self.stage + 1
    self.stageTimer = self.STAGE_TIME
end

function Map:draw()
    for y = 0, self.height - 1 do
        for x = 0, self.width - 1 do
            love.graphics.draw(Map.atlas, Map.quads[self[y][x]], x * Map.tileWidth, y * Map.tileHeight)
        end
    end
end

return Map