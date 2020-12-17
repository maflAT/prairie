-- local aliases for frequently used functions and variables
local newFont = love.graphics.newFont
local font = love.graphics.setFont
local color = love.graphics.setColor
local printf = love.graphics.printf
local print = love.graphics.print
local rect = love.graphics.rectangle

local ww = GAME_WIDTH
local wh = GAME_HEIGHT
local cx = ww / 2
local cy = wh / 2

-- load font assests
local keyCapFont = newFont('/assets/fonts/KeymodeAlphabet.ttf', 12, 'none')
local keyCapSymbols = newFont('/assets/fonts/KeymodeKatakana.ttf', 12, 'none')
local smallFont = newFont('/assets/fonts/goodbyeDespair.ttf', 8, 'mono')
local titleFont = newFont('/assets/fonts/old_pixel-7.ttf', 20, 'normal')

local Line = Class {
    init = function (self, start, lineHeight)
        self.height = lineHeight or 1
        self:reset(start)
    end,
    reset = function (self, start)
        self.currentLine = start or 0
        return self.currentLine
    end,
    next = function (self, lines)
        self.currentLine = self.currentLine + self.height * (lines or 1)
        return self.currentLine
    end,
    current = function (self)
        return self.currentLine
    end
}

local overlay = {}

-- main menu overlay
overlay['menu'] = function ()
    color(0, 0, 0, 0.5)
    rect('fill', cx - 120, 29, 240, 30, 7, 7)
    rect('line', cx - 122, 27, 244, 34, 9, 9)
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
    printf("ESC: quit\tP: pause\tM: mute\tC: credits\tF11: fullscreen\tF1: debug info",
        0, wh - 10, ww, 'center')
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
    rect('fill', ww - 22, pbBot - pbLenght, 5, pbLenght, 2, 2)

    -- lives display
    local hp = map.player.hp
    if hp >= 1 then love.graphics.draw(map.atlas, map.skull, cx - 48, 0) end
    if hp >= 2 then love.graphics.draw(map.atlas, map.skull, cx - 16, 0) end
    if hp >= 3 then love.graphics.draw(map.atlas, map.skull, cx + 16, 0) end
end

-- pause menu
overlay['pause'] = function ()
    color(0, 0, 0, 0.5)
    rect('fill', cx - 120, 29, 240, 30, 7, 7)
    rect('line', cx - 122, 27, 244, 34, 9, 9)
    color(1, 0.98, 0.9, 1)
    font(titleFont)
    printf('PAUSE', 0, 35, ww, 'center')
    color(1, 1, 1, 1)
    printf('Press P to resume', 0, 80, ww, 'center')

    color(1, 1, 1, 0.7)
    font(smallFont)
    printf("ESC: main menu\tP: resume\tM: mute\tF11: fullscreen\tF1: debug info",
        0, wh - 10, ww, 'center')
end

-- game over screen
overlay['gameover'] = function (map)
    color(0, 0, 0, 0.5)
    rect('fill', cx - 120, 29, 240, 30, 7, 7)
    rect('line', cx - 122, 27, 244, 34, 9, 9)
    color(1, 0.98, 0.9, 1)
    font(titleFont)
    printf('GAME OVER', 0, 35, ww, 'center')
    color(1, 1, 1, 1)
    printf('You have reached Stage '..map.stage, 0, 80, ww, 'center')
    printf('Press ESC to return to main menu', 0, cy + 40, ww, 'center')
end

-- credits screen
overlay['credits'] = function ()
    local l = Line(60, smallFont:getHeight() * smallFont:getLineHeight())
    color(0, 0, 0, 0.85)
    rect('fill', 0, 0, ww, wh)
    color({1, 0.98, 0.9, 1})
    printf('Revenge of the Prairie King', titleFont, 0, 35, ww, 'center')

    color(1, 1, 1, 1)
    font(smallFont)
    printf('a game by', 0, l:next(), cx - 2, 'right')
    printf('for', 0, l:next(), cx - 2, 'right')
    printf('written in', 0, l:next(2), cx - 2, 'right')
    printf('using:', 0, l:next(2), cx - 2, 'right')
    printf('by', 0, l:next(3), cx - 2, 'right')
    printf('by', 0, l:next(3), cx - 2, 'right')
    printf('graphics and music by', 0, l:next(2), cx - 2, 'right')
    printf('fonts by', 0, l:next(2), cx - 2, 'right')
    printf('inspired by', 0, l:next(2), cx - 2, 'right')

    l:reset(60)
    printf('markus f.', cx + 2, l:next(), ww, 'left')
    printf('cs50x', cx + 2, l:next(), ww, 'left')
    printf('lua', cx + 2, l:next(2), ww, 'left')
    printf('LOVE-2D framework', cx + 2, l:next(2), ww, 'left')
    printf('Helper Utilities for Massive Progression', cx + 2, l:next(2), ww, 'left')
    printf('Matthias Richter', cx + 2, l:next(), ww, 'left')
    printf('push library', cx + 2, l:next(2), ww, 'left')
    printf('Ulysse Ramage', cx + 2, l:next(), ww, 'left')
    printf('Estudio Vaca Roxa', cx + 2, l:next(2), ww, 'left')
    printf('Sizenko Alexander, Kato Masashi', cx + 2, l:next(2), ww, 'left')
    printf('Journey of the Prairie King,\nGeometry Wars,\n...', cx + 2, l:next(2), ww, 'left')

    printf('2020', 0, l:next(4), ww, 'center')
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