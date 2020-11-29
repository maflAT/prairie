local Animation = require 'Animation'

return Class{
    init = function(self, modelDefinition)
        self.states = modelDefinition.states
        -- assuming 'idle'/'south' as the default state for all models
        self.state = 'idle'
        self.subState = 'south'
        self.current = self.states[self.state][self.subState]

        -- load sprite sheets and generate quads; append processed data to player model
        local spriteSheets, quads = {}, {}
        for k, sprites in pairs(modelDefinition.sprites) do
            spriteSheets[k] = love.graphics.newImage(sprites.file)
            quads[k] = generateQuads(spriteSheets[k], sprites.tileWidth, sprites.tileHeight)
        end

        -- initialize animation for each state in player model
        for _, state in pairs(self.states) do
            for _, subState in pairs(state) do
                subState.spriteSheet = spriteSheets[subState.sprites]
                subState.quads = quads[subState.sprites]
                subState.animation = Animation(subState.frames, subState.updateRate)
            end
        end
    end,

    setState = function(self, state, subState)
        if self.state ~= state or self.subState ~= subState then
            self.state = self.states[state] and state or self.state
            self.subState = self.states[state][subState] and subState or self.subState
            self.current = self.states[self.state][self.subState]
            self.current.animation:reset()
        end
    end,

    update = function(self, dt)
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