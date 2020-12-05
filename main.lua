--[[ 
    TODO: enemies, obstacles, collision detection, hit detection
]]

Class = require 'assets.hump.class'
Entity = require 'Entity'
Projectile = require 'Projectile'
AnimationModel = require 'Model'
ModelDefinitions = {
    Player = require '/models/player',
    Cactus = require '/models/cactus',
    Coffin = require '/models/coffin',
    Coyote = require '/models/coyote',
}
Bullets = {}
Mobs = {}
require 'utils'

local push = require 'assets.push.push'
local map = require 'Map' ()
local player = require 'Player' (ModelDefinitions.Player, GAME_WIDTH / 2, GAME_HEIGHT / 2)
local coffin = require 'Enemy' (ModelDefinitions.Coffin, 50, 50)
local cactus = require 'Enemy' (ModelDefinitions.Cactus, GAME_WIDTH - 50, GAME_HEIGHT - 50)
local coyote = require 'Enemy' (ModelDefinitions.Coyote, 50, GAME_HEIGHT - 50)
-- local keysPressed = {}

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        pixelperfect = false,
    })
end

function love.update(dt)
    player:update(dt)
    coffin:update(dt)
    cactus:update(dt)
    coyote:update(dt)
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
    coffin:draw()
    cactus:draw()
    coyote:draw()
    for _, bullet in pairs(Bullets) do
        bullet:draw()
    end
    debugText:draw(map, player)
    push:finish()
end

function love.keypressed(k)
    if k == 'escape' then love.event.quit()
    elseif k == '^' then debugText:toggle()
    -- else
    --     table.insert(keysPressed, #keysPressed + 1, k)
    end
end

function love.resize(w, h)
    push:resize(w, h)
end