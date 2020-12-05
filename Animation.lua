-- Animation base class:
-- takes a list of frames and returns the current frame on 'draw'
-- 'frames' can be a 1-indexed array of any type
-- 'frameTime' is the time in seconds between frames

return Class {
    init = function(self, frames, frameTime)
        self.frames = frames
        self.frameTime = frameTime
        self:reset()
    end,

    -- reset animation to startFrame or first frame if no startFrame is supplied
    reset = function(self, startFrame)
        self.timer = self.frameTime
        self.currentFrame = startFrame and startFrame >= 1 or 1
    end,

    -- update current frame based on delta time; 
    -- return true if animation loop has been completed
    update = function(self, dt)
        self.timer = self.timer - dt
        if self.timer <= 0 then
            self.timer = self.timer + self.frameTime
            self.currentFrame = self.currentFrame % #self.frames + 1
            return self.currentFrame == 1 and true or false
        end
    end,

    draw = function(self)
        return self.frames[self.currentFrame]
    end
}