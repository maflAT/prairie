-- Animation base class:
-- takes a list of frames and returns the current frame on 'draw'
-- 'frames' can be a 1-indexed array of any type
-- 'updateRate' is the time in seconds between frames

return Class {
    init = function(self, frames, updateRate)
        self.frames = frames
        self.updateRate = updateRate
        self:reset()
    end,
    reset = function(self)
        self.timeout = self.updateRate
        self.currentFrame = 1
    end,
    update = function(self, dt)
        self.timeout = self.timeout - dt
        if self.timeout <= 0 then
            self.timeout = self.timeout + self.updateRate
            self.currentFrame = self.currentFrame % #self.frames + 1
            -- return true if loop has been completed
            return self.currentFrame == 1 and true or false
        end
    end,
    draw = function(self)
        return self.frames[self.currentFrame]
    end
}