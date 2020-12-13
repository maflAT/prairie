-- Animation base class:
-- takes a list of frames and returns the current frame on 'draw'
-- 'frames' can be a 1-indexed array of any type
-- 'frameTime' is the time in seconds between frames

return Class {
    init = function(self, frames, frameTime)
        self.loop = true
        self.frames = frames
        self.frameTime = frameTime
        self:reset()
    end,

    -- reset animation to startFrame or first frame if no startFrame is supplied
    reset = function(self, startFrame, loop)
        if loop == false then self.loop = false else self.loop = true end
        self.timer = self.frameTime
        self.currentFrame = (startFrame and startFrame >= 1) and startFrame or 1
    end,

    update = function(self, dt)
        self.timer = self.timer - dt
        if self.timer <= 0 then
            self.timer = self.timer + self.frameTime
            if self.currentFrame < #self.frames then
                self.currentFrame = self.currentFrame + 1
            else
                if self.loop then self.currentFrame = 1 end
                return true
            end
        end
        return false
    end,

    draw = function(self)
        return self.frames[self.currentFrame]
    end
}