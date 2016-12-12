local Cruft = require('./entities/cruft')

Clutterer = {}

-- Constructor
function Clutterer:new(width, height)
  newObj = {
    width = width,
    height = height
  }
  self.__index = self
  return setmetatable(newObj, self) 
end

-- Generate a spawn location.
function Clutterer:spawnLocation()
  return {
    x = math.random(0, self.width),
    y = math.random(0, self.height)
  }
end

-- Randomly decide to spawn or not.
function Clutterer:shouldSpawn(count)
  -- If we haven't reached the limit
  if count < 5 then
    return true
  end

  return false
end

-- Convenience method for spawning.
function Clutterer:spawn()
  position = self:spawnLocation()
  return Cruft:new(position.x, position.y)
end

return Clutterer