-- This class serves as a collection for all animations of the player.
-- It initializes and manages all combinations of behaviours and orientations.

local Animation = require 'Animation'
local Model = Class{}

Model.doing = ''                 -- current behaviour as string
Model.facing = ''                -- current orientation as string
Model.behaviour = {}             -- current behaviour as object
Model.orientation = {}           -- current orientation as object
Model.animation = {}             -- current animation (short hand)
Model.animationComplete = false

function Model:init(model)
    self.behaviours = model.behaviours
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
    for _, attributes in pairs(self.orientations) do
        -- fill in defaults for missing attributes
        for attribute, defaultValue in pairs(model.defaults.orientations) do
            attributes[attribute] = attributes[attribute] or defaultValue
        end
        -- append imported sprite sheets and generated quads to attributes
        attributes.spriteSheet = spriteSheets[attributes.sprites]
        attributes.quads = quads[attributes.sprites]
    end

    -- complete attributes for each behaviour
    for _, attributes in pairs(self.behaviours) do
        -- fill in defaults for missing attributes
        for attribute, defaultValue in pairs(model.defaults.behaviours) do
            attributes[attribute] = attributes[attribute] or defaultValue
        end
        -- initialize animation sequence for each behaviour
        attributes.animation = Animation(attributes.frames, attributes.updateRate)
    end

    -- initialize to default state
    self:doo(model.defaults.behaviour or 'idle')
    self:face(model.defaults.orientation or 'south')
end

function Model:doo(behaviour)
    -- if desired state is defined, set it and start its animation,
    -- else keep current state
    if behaviour ~= nil and behaviour ~= self.doing and self.behaviours[behaviour] then
        self.doing = behaviour
        self.behaviour = self.behaviours[behaviour]
        self.animation = self.behaviour.animation
        self.animation:reset()
    end
end

function Model:face(direction)
    if direction ~= nil and direction ~= self.facing and self.orientations[direction] then
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
    local b, o = self.behaviour, self.orientation
    local sheet = o.spriteSheet
    local quad = o.quads[b.animation:draw()]
    love.graphics.draw(sheet, quad, round(x), round(y),
    0, o.xScale, o.yScale, o.xOffset, o.yOffset)
end

return Model