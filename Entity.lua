return Class {

    init = function(self, x, y)
        self.x = x
        self.y = y
    end,

    draw = function(self)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle('fill', self.x, self.y, 2, 2)
    end
}