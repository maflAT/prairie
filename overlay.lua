-- local aliases for frequently used functions and variables
local newFont = love.graphics.newFont
local font = love.graphics.setFont
local color = love.graphics.setColor
local printf = love.graphics.printf
local print = love.graphics.print

local ww = GAME_WIDTH
local wh = GAME_HEIGHT
local cx = ww / 2
local cy = wh / 2

-- load font assests
local keyCapFont = newFont('/assets/fonts/KeymodeAlphabet.ttf', 12, 'none')
local keyCapSymbols = newFont('/assets/fonts/KeymodeKatakana.ttf', 12, 'none')
local smallFont = newFont('/assets/fonts/goodbyeDespair.ttf', 8, 'none')
local titleFont = newFont('/assets/fonts/old_pixel-7.ttf', 20, 'normal')

local overlay = {}

-- main menu overlay
overlay['menu'] = function ()
    color(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', cx - 120, 29, 240, 30, 7, 7)
    love.graphics.rectangle('line', cx - 122, 27, 244, 34, 9, 9)
    color(1, 0.98, 0.9, 1)
    font(titleFont)
    printf('Revenge of the Prairie King', 0, 35, ww, 'center')
    color(1, 1, 1, 1)
    printf('Press ENTER to play', 0, 80, ww, 'center')

    color(1, 1, 1, 0.7)
    font(keyCapFont)
    printf('W', 0, cy + 25, cx, 'center')
    printf('ASD', 0, cy + 38, cx, 'center')

    font(keyCapSymbols)
    -- U/N/Y/O represent up/left/down/right arrow keys
    printf('U', cx, cy + 25, cx, 'center')
    printf('NYO', cx, cy + 38, cx, 'center')

    font(titleFont)
    printf('move', -1, cy + 50, cx, 'center')
    printf('shoot', cx, cy + 50, cx, 'center')

    font(smallFont)
    printf("ESC: quit\t\tP: pause\t\tF11: fullscreen\t\tF1: debug info", 0, wh - 10, ww, 'center')
end

-- gameplay info overlay
overlay['playing'] = function (map)
    -- stage display
    font(titleFont)
    color(1, 1, 1, 0.5)
    printf('Stage' .. tostring(map.stage), ww - 37, 2, 36, 'center')

    -- stage progress bar
    local pbTop = 38
    local pbBot = wh - 20
    local progress = 1 - (map.stageTimer / map.STAGE_TIME)
    local pbLenght = (pbBot - pbTop) * progress
    love.graphics.rectangle('fill', ww - 22, pbBot - pbLenght, 5, pbLenght, 2, 2)

    -- lives display
    local hp = map.player.hp
    if hp >= 1 then love.graphics.draw(map.atlas, map.skull, cx - 48, 0) end
    if hp >= 2 then love.graphics.draw(map.atlas, map.skull, cx - 16, 0) end
    if hp >= 3 then love.graphics.draw(map.atlas, map.skull, cx + 16, 0) end
end

-- pause menu
overlay['pause'] = function ()
    color(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', cx - 120, 29, 240, 30, 7, 7)
    love.graphics.rectangle('line', cx - 122, 27, 244, 34, 9, 9)
    color(1, 0.98, 0.9, 1)
    font(titleFont)
    printf('PAUSE', 0, 35, ww, 'center')
    color(1, 1, 1, 1)
    printf('Press P to resume', 0, 80, ww, 'center')

    color(1, 1, 1, 0.7)
    font(smallFont)
    printf("ESC: main menu\t\tP: resume\t\tF11: fullscreen\t\tF1: debug info", 0, wh - 10, ww, 'center')
end

-- game over screen
overlay['gameover'] = function (map)
    color(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', cx - 120, 29, 240, 30, 7, 7)
    love.graphics.rectangle('line', cx - 122, 27, 244, 34, 9, 9)
    color(1, 0.98, 0.9, 1)
    font(titleFont)
    printf('GAME OVER', 0, 35, ww, 'center')
    color(1, 1, 1, 1)
    printf('You have reached Stage '..map.stage, 0, 80, ww, 'center')
    printf('Press ESC to return to main menu', 0, cy + 40, ww, 'center')
end

-- display various debug information
overlay['debug'] = {
    enabled = false,
    toggle = function(self)
        self.enabled = not self.enabled
    end,
    draw = function(self, map, player)
        if self.enabled then
            color(0, 0.8, 0, 0.7)
            font(smallFont)
            print('FPS: ' .. tostring(love.timer.getFPS()), 1, 0)
            print('Entities: ' .. len(gEntities), 1, 8)
            print('Game state: ' .. gGameState, 1, 16)
            print('Player State: ' .. player.model.doing, 1, 24)
            print('Frame: ' .. player.model.animation.currentFrame, 1, 32)
            print('Life: ' .. player.hp, 1, 40)
            print('stage: ' .. tostring(map.stage), 1, 48)
            print('stage timer: ' .. string.format('%.1f', map.stageTimer or 0), 1, 56)
            print('spawn timer: ' .. string.format('%.1f', map.spawnTimer or 0), 1, 64)
        end
    end,
}
return overlay