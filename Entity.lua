-- Entity class:
-- serves as a base class for players, enemies, projectiles;
-- manages basic attributes for drawing and collision detection;
-- includes global list, containing all entities;
-- as well as utility function to manage entities.

-- ===========================
-- global list of all entities
-- ===========================
gEntities = {}

-- =================
-- utility functions
-- =================
-- sort entities by depht / z-coordinate
local function zSort(entities)
    local buffer = {}
    for _, entity in pairs(entities) do table.insert(buffer, entity) end
    table.sort(buffer, function(e1, e2) return e1.z < e2.z end)
    return buffer
end

-- draw all entities in correct z-order
function drawAll(entities)
    entities = zSort(entities)
    for _, entity in ipairs(entities) do entity:draw() end
end

-- remove all entities from collection, that are marked for deletion
function cleanUp(entities)
    local killList = {}
    for k, entity in pairs(entities) do
        if entity.delete then table.insert(killList, k) end
    end
    for _, entity in pairs(killList) do entities[entity] = nil end
end

-- ================
-- class definition
-- ================
local Entity = Class{}

function Entity:init(x, y, width, height, zOffset)
    table.insert(gEntities, self)
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