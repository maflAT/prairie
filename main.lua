
Class = require 'assets.hump.class'
Entity = require 'Entity'
local Projectile = require 'Projectile'
local Player = require 'Player'

local push = require 'assets.push.push'
local bullet, player

function love.load()
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        pixelperfect = true,
    })
    bullet = Projectile(0, 0, 75, 25)
    player = Player(320, 0, -100, 60)
end

function love.update(dt)
    bullet:update(dt)
    player:update(dt)
end

function love.draw()
    push:start()
    love.graphics.clear()
    love.graphics.print("test" .. GAME_WIDTH)
    bullet:draw()
    player:draw()
    push:finish()
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.quit()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end