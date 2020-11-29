
Class = require 'assets.hump.class'
require 'utils'
local Map = require 'Map'
Entity = require 'Entity'
Projectile = require 'Projectile'
Projectiles = {}

local Player = require 'Player'
local push = require 'assets.push.push'
local player, map
-- local keysPressed = {}

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        pixelperfect = true,
    })
    map = Map()
    player = Player(GAME_WIDTH / 2, GAME_HEIGHT / 2)
end

function love.update(dt)
    player:update(dt)
    for _, bullet in pairs(Projectiles) do
        bullet:update(dt)
    end
end

function love.draw()
    push:start()
    love.graphics.clear(0.9, 0.8, 0.3, 1)
    map:draw()
    player:draw()
    for _, bullet in pairs(Projectiles) do
        bullet:draw()
    end
    displayFPS()
    push:finish()
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    -- else
    --     table.insert(keysPressed, #keysPressed + 1, k)
    end
end

function love.resize(w, h)
    push:resize(w, h)
end