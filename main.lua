--[[
    TODO: game state, hit and death animations, obstacles,
]]

-- load global classes / modules; register locals
require 'utils'
Class = require 'assets/hump/class'
Entity = require 'Entity'
Projectile = require 'Projectile'
AnimationModel = require 'Model'
local push, player, map = {}, {}, {}

function love.load()
    math.randomseed(os.time())

    -- load classes / modules / assets
    -- outlineFont = love.graphics.newFont('/assets/fonts/Fipps.otf', 8)
    smallFont = love.graphics.newFont('/assets/fonts/goodbyeDespair.ttf', 8)
    tinyFont = love.graphics.newFont('/assets/fonts/04B_03B_.ttf', 8)
    love.graphics.setFont(smallFont)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push = require 'assets/push/push'
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        pixelperfect = false,
        fullscreen = false,
    })

    player = require 'Player' (require '/models/player', GAME_WIDTH / 2, GAME_HEIGHT / 2)
    map = require 'map' (player)
end

function love.update(dt)
    -- dt = dt / 5
    map:update(dt)

    -- cleanup dead entities
    cleanUp(Entities, Mobs, Bullets)
end

function love.draw()
    push:start()
    love.graphics.clear(0.9, 0.8, 0.3, 1)
    map:draw()

    -- sort entities in z-Order so they overlap correctly
    local buffer = {}
    for _, entity in pairs(Entities) do table.insert(buffer, entity) end
    table.sort(buffer, function(a, b) return a.z < b.z end)
    Entities = buffer
    for _, entity in ipairs(Entities) do entity:draw() end

    debugText:draw(map, player)
    push:finish()
end

function love.keypressed(k)
    if k == 'escape' then
        if love.window.getFullscreen() then
            push:switchFullscreen(WINDOW_WIDTH, WINDOW_HEIGHT)
        else
            love.event.quit()
        end
    elseif k == 'f11' then push:switchFullscreen(WINDOW_WIDTH, WINDOW_HEIGHT)
    elseif k == '^' then debugText:toggle()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end