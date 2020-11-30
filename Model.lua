local Animation = require 'Animation'

return Class{
    init = function(self, model)
        self.states = model.states
        -- assuming 'idle'/'south' as the default state for all models
        self.state = 'idle'
        self.subState = 'south'
        self.current = self.states[self.state][self.subState]

        -- load sprite sheets and generate quads; append processed data to player model
        local spriteSheets, quads = {}, {}
        for k, sprites in pairs(model.sprites) do
            spriteSheets[k] = love.graphics.newImage(sprites.file)
            quads[k] = generateQuads(spriteSheets[k], sprites.tileWidth, sprites.tileHeight)
        end

        -- initialize attributes for each state in player model
        for state, subStates in pairs(self.states) do
            for subState, attributes in pairs(subStates) do
                for attribute, defaultVal in pairs(model.attributes.default) do
                    attributes[attribute] = 
                        model.attributes[state][subState][attribute]
                        or model.attributes[state]['default'][attribute]
                        or defaultVal
                end
                attributes.spriteSheet = spriteSheets[attributes.sprites]
                attributes.quads = quads[attributes.sprites]
                attributes.animation = Animation(attributes.frames, attributes.updateRate)
            end
        end
    end,

    setState = function(self, state, subState)
        -- if desired state is defined, set it and start its animation,
        -- else keep current state
        if self.state ~= state or self.subState ~= subState then
            self.state = self.states[state] and state or self.state
            self.subState = self.states[state][subState] and subState or self.subState
            self.current = self.states[self.state][self.subState]
            self.current.animation:reset()
        end
        return state, subState
    end,

    update = function(self, dt)
        -- return true if current loop has been completed
        return self.current.animation:update(dt)
    end,

    draw = function(self, x, y)
        local s = self.current
        local sheet = s.spriteSheet
        local quad = s.quads[s.animation:draw()]
        love.graphics.draw(sheet, quad, round(x), round(y),
        0, s.xScale, s.yScale, s.xOffset, s.yOffset)
    end
}