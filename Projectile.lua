BULLET_SPEED = 400  --in pixel/sec

return Class {__includes = Entity,

    init = function(self, x, y, vx, vy)
        Entity.init(self, x, y)
        self.vx = vx * BULLET_SPEED
        self.vy = vy * BULLET_SPEED
    end,

    update = function(self, dt)
        self.x = self.x + self.vx * dt
        self.y = self.y + self.vy * dt
    end,
    foo = function (self)
        print("bar")
    end
}