Entities = {}

local Entity = Class{}

function Entity:init(x, y, width, height)
    table.insert(Entities, self)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.delete = false
    self:getBB()
end

function Entity:getBB()
    self.boundingBox = {
        le = self.x,
        ri = self.x + self.width,
        top = self.y,
        bot = self.y + self.height}
    return self.boundingBox
end

function Entity:kill()
    self.delete = true
end

return Entity