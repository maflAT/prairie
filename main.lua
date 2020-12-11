--[[
    TODO: game state, hit and death animations, obstacles,
]]

-- load global classes / modules; register locals
require 'utils'
Class = require 'assets/hump/class'
Entity = require 'Entity'
Projectile = require 'Projectile'
AnimationModel = require 'Model'
gGameState = 'init'
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

    gGameState = 'menu'
end

local debug_Timelapse = 1
function love.update(dt)

    if gGameState == 'menu' then
        player.model:update(dt)

    elseif gGameState == 'playing' then
        dt = dt / (debug_Timelapse > 0 and debug_Timelapse or 1)
        map:update(dt)

        -- remove dead entities from collections
        doAll(cleanUp, gEntities, Mobs, Bullets)
    end
end

function love.draw()
    push:start()

    if gGameState == 'menu' then
        love.graphics.clear(0.9, 0.8, 0.3, 1)
        map:draw()
        player:draw()
        love.graphics.printf('Press "Enter" to play', 0, 0, GAME_WIDTH, 'center')
    elseif gGameState == 'playing' then
        map:draw()
        drawAll(gEntities)
    elseif gGameState == 'gameover' then
        love.graphics.printf('Press "Enter" to play', 0, 0, GAME_WIDTH, 'center')
    end

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
    elseif k == 'return' then gGameState = 'playing'
    elseif k == 'f11' then push:switchFullscreen(WINDOW_WIDTH, WINDOW_HEIGHT)
    elseif k == '^' then debugText:toggle()
    elseif k == 'f5' then debug_Timelapse = debug_Timelapse + 1
    elseif k == 'f6' then debug_Timelapse = debug_Timelapse - 1
    end
end

function love.resize(w, h)
    push:resize(w, h)
end