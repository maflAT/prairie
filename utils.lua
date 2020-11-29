local invSqr2 = 1 / math.sqrt(2)

function dir8(upKey, downKey, leftKey, rightKey)
    local x, y = 0.0, 0.0
    if love.keyboard.isDown(upKey)    then y = -1    end
    if love.keyboard.isDown(downKey)  then y = y + 1 end
    if love.keyboard.isDown(leftKey)  then x = -1    end
    if love.keyboard.isDown(rightKey) then x = x + 1 end

    if x ~= 0 and y ~= 0 then x = x * invSqr2; y = y * invSqr2 end
    return x, y
end

function displayFPS()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 1, 0, 0.6)
    love.graphics.print(tostring(love.timer.getFPS()), 40, 20)
    love.graphics.setColor(r, g, b, a)
end