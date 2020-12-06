--[[ 
    TODO: enemies, obstacles, collision detection, hit detection
]]

-- load classes / modules
Class = require 'assets/hump/class'
require 'utils'
Entity = require 'Entity'
Projectile = require 'Projectile'
AnimationModel = require 'Model'
local Enemy = require 'Enemy'
local push = require 'assets/push/push'
local map = require 'Map' ()
local charData = {
    Player = require '/models/player',
    Cactus = require '/models/cactus',
    Coffin = require '/models/coffin',
    Coyote = require '/models/coyote',
}
-- spawn player
local player = require 'Player' (charData.Player, GAME_WIDTH / 2, GAME_HEIGHT / 2)

function love.load()
    math.randomseed(os.time())
    -- outlineFont = love.graphics.newFont('/assets/fonts/Fipps.otf', 8)
    smallFont = love.graphics.newFont('/assets/fonts/goodbyeDespair.ttf', 8)
    tinyFont = love.graphics.newFont('/assets/fonts/04B_03B_.ttf', 8)
    love.graphics.setFont(smallFont)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        pixelperfect = false,
    })
    -- spawn some enemies
    Enemy(charData.Coffin, 50, 50)
    Enemy(charData.Cactus, GAME_WIDTH - 50, GAME_HEIGHT - 50)
    Enemy(charData.Coyote, 50, GAME_HEIGHT - 50)
end

function love.update(dt)
    player:update(dt)
    for _, mob in pairs(Mobs) do
        mob:update(dt)
    end
    for _, bullet in pairs(Bullets) do
        bullet:update(dt)
    end

    -- cleanup dead entities
    cleanUp(Entities, Mobs, Bullets)
end

function love.draw()
    push:start()
    love.graphics.clear(0.9, 0.8, 0.3, 1)
    map:draw()
    player:draw()
    for _, mob in pairs(Mobs) do
        mob:draw()
    end
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