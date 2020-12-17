--[[
    TODO: hit and death animations, sound effects, obstacles,
]]

-- load global classes / modules; register locals
require 'utils'
music = love.audio.newSource('assets/music/Welcome To The Wild West.ogg', 'static')
music:setVolume(0.5)
music:setLooping(true)
Class = require 'assets/hump/class'
Entity = require 'Entity'
Projectile = require 'Projectile'
AnimationModel = require 'Model'
gGameState = 'init'
local push, player, map, overlay = {}, {}, {}, {}


-- setup and initialize game state, map, player, ...
function love.load()
    math.randomseed(os.time())

    -- load classes / modules / assets
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push = require 'assets/push/push'
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
        {resizable = true, pixelperfect = false, fullscreen = false,})

    player = require 'Player' (require '/Models/player')
    map = require 'Map' (player)
    overlay = require 'overlay'
    gGameState = 'menu'
    music:play()
end


-- advance game state
local debug_TimeScale = 1
function love.update(dt)

    if gGameState == 'menu' then
        player.model:update(dt)

    elseif gGameState == 'playing' then
        dt = dt * debug_TimeScale
        map:update(dt)
        -- remove dead entities from collections
        doAll(cleanUp, gEntities, gMobs, gBullets)

    elseif gGameState == 'pause'  then
        -- placeholder

    elseif gGameState == 'gameover'  then
        player.model:update(dt)

    elseif gGameState == 'credits'  then
        -- placeholder
    end
end


-- render current scene
function love.draw()
    push:start()

    map:draw()
    drawAll(gEntities)
    overlay[gGameState](map)
    overlay.debug:draw(map, player)

    push:finish()
end


function love.keypressed(k)
    -- shared keybinds for all game states
    if k == 'm' then
        love.audio.setVolume(love.audio.getVolume() == 0 and 1 or 0)
    elseif k == 'f11' then push:switchFullscreen(WINDOW_WIDTH, WINDOW_HEIGHT)
    elseif k == 'f1' then overlay.debug:toggle()
    end

    -- state specific keybinds
    if gGameState == 'menu' then
        if k == 'escape' then
            love.event.quit()
        elseif k == 'return' then
            gGameState = 'playing'
            map:reset()
        elseif k == 'c' then
            gGameState = 'credits'
        end
    elseif gGameState == 'playing' then
        if k == 'escape' or k == 'p' then
            gGameState = 'pause'
        elseif k == 'f5' then debug_TimeScale = debug_TimeScale / 2
        elseif k == 'f6' then debug_TimeScale = debug_TimeScale * 2
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
    elseif gGameState == 'credits' then
        if k == 'escape' or k == 'c' then
            gGameState = 'menu'
        end
    end
end


function love.resize(w, h)
    push:resize(w, h)
end