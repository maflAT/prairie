--[[
    TODO: hit and death animations, obstacles,
]]

-- load global classes / modules; register locals
require 'utils'
Class = require 'assets/hump/class'
Entity = require 'Entity'
Projectile = require 'Projectile'
AnimationModel = require 'Model'
gGameState = 'init'
local push, player, map, overlay = {}, {}, {}, {}


function love.load()
    math.randomseed(os.time())

    -- load classes / modules / assets
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push = require 'assets/push/push'
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
        {resizable = true, pixelperfect = false, fullscreen = false,})

    player = require 'Player' (require '/models/player')
    map = require 'map' (player)
    overlay = require 'overlay'
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
        doAll(cleanUp, gEntities, gMobs, gBullets)

    elseif gGameState == 'pause'  then
    elseif gGameState == 'gameover'  then
    end
end


function love.draw()
    push:start()

    map:draw()
    drawAll(gEntities)
    overlay[gGameState](map)

    -- if gGameState == 'menu' then
    -- elseif gGameState == 'playing' then
    -- elseif gGameState == 'pause'  then
    -- elseif gGameState == 'gameover'  then
    -- end

    overlay.debug:draw(map, player)
    push:finish()
end


function love.keypressed(k)
    -- shared keybinds for all game states
    if k == 'f11' then push:switchFullscreen(WINDOW_WIDTH, WINDOW_HEIGHT)
    elseif k == 'f1' then overlay.debug:toggle()
    elseif k == 'f5' then debug_Timelapse = debug_Timelapse + 1
    elseif k == 'f6' then debug_Timelapse = debug_Timelapse - 1
    end

    -- state specific keybinds
    if gGameState == 'menu' then
        if k == 'escape' then
            love.event.quit()
        elseif k == 'return' then
            gGameState = 'playing'
            map:reset()
        end
    elseif gGameState == 'playing' then
        if k == 'escape' or k == 'p' then
            gGameState = 'pause'
        end
    elseif gGameState == 'pause'  then
        if k == 'escape' then
            gGameState = 'menu'
            map:reset()
        elseif k == 'p' then
            gGameState = 'playing'
        end
    elseif gGameState == 'gameover'  then
        if k == 'escape' then
            gGameState = 'menu'
            map:reset()
        end
    end
end


function love.resize(w, h)
    push:resize(w, h)
end