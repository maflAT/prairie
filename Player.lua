return Class {__includes = Entity,

    init = function(self, x, y, vx, vy)
        Entity.init(self, x, y)
        self.vx = vx
        self.vy = vy
        self.width = 12
        self.height = 20
    end,

    update = function(self, dt)
        self.x = self.x + self.vx * dt
        self.y = self.y + self.vy * dt
        self.vx = self.vx * 0.99
        self.vy = self.vy * 0.99
    end,
    draw = function (self)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    end
}