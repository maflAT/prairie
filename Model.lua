local Animation = require 'Animation'

return Class{
    init = function(self, modelDefinition)
        self.states = modelDefinition.states
        
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
        self.state = state
        self.subState = subState
        self.current = self.states[state][subState]
        self.current.animation:reset()
    end,
    update = function(self, dt)
        self.current.animation:update(dt)
    end,
    draw = function(self, x, y)
        local sheet = self.current.spriteSheet
        local quad = self.current.animation:draw()
        quad = self.current.quads[quad]
        love.graphics.draw(sheet, quad, round(x), round(y),
        0, 1, 1, 15, 16)
    end
}