--[[ 
    TODO: enemies, obstacles, collision detection, hit detection
 ]]
require 'utils'
Class = require 'assets.hump.class'
Entity = require 'Entity'
Projectile = require 'Projectile'
Bullets = {}

local Map = require 'Map'
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
    local delete = {}
    for i, bullet in pairs(Bullets) do
        bullet:update(dt)
        if bullet.delete then table.insert(delete, #delete + 1, i) end
    end
    for _, bullet in pairs(delete) do Bullets[bullet] = nil end

end

function love.draw()
    push:start()
    love.graphics.clear(0.9, 0.8, 0.3, 1)
    map:draw()
    player:draw()
    for _, bullet in pairs(Bullets) do
        bullet:draw()
    end
    displayFPS()
    love.graphics.print(#Bullets, 4, 30)
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