-- This class serves as a collection for all animations of the player.
-- It initializes and manages all combinations of behaviours and orientations.

local Animation = require 'Animation'
local Model = Class{}

function Model:init(model)
    self.actions = model.behaviours
    self.orientations = model.orientations

    -- load sprite sheets and generate quads for all sprites listed in the player model
    local spriteSheets, quads = {}, {}
    for sheetNum, sheet in pairs(model.sprites) do
        spriteSheets[sheetNum] = love.graphics.newImage(sheet.file)
        local tileWidth = sheet.tileWidth or model.defaults.sprites.tileWidth
        local tileHeight = sheet.tileHeight or model.defaults.sprites.tileHeight
        quads[sheetNum] = generateQuads(spriteSheets[sheetNum], tileWidth, tileHeight)
    end

    -- complete attributes for each orientation
    for _, orientation in pairs(self.orientations) do
        -- fill in defaults for missing attributes
        for attribute, defaultValue in pairs(model.defaults.orientations) do
            orientation[attribute] = orientation[attribute] or defaultValue
        end
        -- append imported sprite sheets and generated quads to attributes
        orientation.spriteSheet = spriteSheets[orientation.sprites]
        orientation.quads = quads[orientation.sprites]
    end

    -- complete attributes for each behaviour
    self.animations = {}
    for key, action in pairs(self.actions) do
        -- fill in defaults for missing attributes
        for attribute, defaultValue in pairs(model.defaults.behaviours) do
            action[attribute] = action[attribute] or defaultValue
        end
        -- initialize animation sequence for each behaviour
        self.animations[key] = Animation(action.frames, action.updateRate)
    end

    -- initialize to default state
    self:doo(model.defaults.behaviour or 'idle')
    self:face(model.defaults.orientation or 'south')
end

function Model:doo(action, loop)
    -- abort function / keep current state if action is not defined
    if action == nil or self.actions[action] == nil then return nil end

    -- if action differs from current, set it and start its animation,
    if action ~= self.doing then
        self.doing = action
        self.action = self.actions[action]
        self.animation = self.animations[action]
        self.animation:reset(nil, loop)
    else
        -- otherwise, only update loop parameter
        if loop ~= nil then self.animation.loop = loop end
    end
end

function Model:doOnce(action) return self:doo(action, false) end

function Model:face(direction)
    -- abort function / keep current orientation if direction is not defined
    if direction == nil or self.orientations[direction] == nil then return nil end

    if direction ~= self.facing then
        self.facing = direction
        self.orientation = self.orientations[direction]
        self.animation:reset()
    end
end

function Model:update(dt)
    -- return true if current loop has been completed
    self.animationComplete = self.animation:update(dt)
    return self.animationComplete
end

function Model:draw(x, y)
    local o = self.orientation
    love.graphics.draw(o.spriteSheet, o.quads[self.animation:draw()],
    round(x), round(y), 0, o.xScale, o.yScale, o.xOffset, o.yOffset)
end

return Model