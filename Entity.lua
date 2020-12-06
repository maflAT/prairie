Entities = {}

local Entity = Class{}

function Entity:init(x, y, width, height, zOffset)
    table.insert(Entities, self)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.zOffset = zOffset or self.height
    self.z = self.y + self.zOffset
    self.delete = false
    self.boundingBox = {}
    Entity.update(self)
end

function Entity:update()
    self.boundingBox = {
        le = self.x,
        ri = self.x + self.width,
        top = self.y,
        bot = self.y + self.height
    }
    self.z = self.y + self.zOffset
end

function Entity:kill()
    self.delete = true
end

return Entity