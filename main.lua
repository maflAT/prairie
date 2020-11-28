
Class = require 'assets.hump.class'
require 'utils'
Entity = require 'Entity'
Projectile = require 'Projectile'
Projectiles = {}
local Player = require 'Player'

local push = require 'assets.push.push'
local player
-- local keysPressed = {}

function love.load()
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        pixelperfect = true,
    })
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
    love.graphics.clear()
    love.graphics.print("test" .. GAME_WIDTH)
    player:draw()
    for _, bullet in pairs(Projectiles) do
        bullet:draw()
    end
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