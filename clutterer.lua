local Cruft = require('./entities/cruft')

Clutterer = {}

-- Constructor
function Clutterer:new(width, height)
  newObj = {
    width = width,
    height = height,
    threshold = 1,
    last = os.time(),
    clutter = {},
    limit = 20
  }
  self.__index = self
  return setmetatable(newObj, self) 
end

-- Remove clutter at the given index.
function Clutterer:remove(i)
  table.remove(self.clutter, i)
end

-- Generate a spawn location.
function Clutterer:spawnLocation()
  return {
    x = math.random(0, self.width),
    y = math.random(0, self.height)
  }
end

-- Randomly decide to spawn or not.
function Clutterer:shouldSpawn(params)
  -- If we haven't reached the limit
  if self:thresholdMet() and #self.clutter <= self.limit then
    return true
  end

  return false
end

-- Has the threshold for spawning been met?
function Clutterer:thresholdMet()
  return os.difftime(os.time(), self.last) > self.threshold
end

-- Convenience method for spawning.
function Clutterer:spawn()
  position = self:spawnLocation()
  self.clutter[#self.clutter + 1] = Cruft:new(position.x, position.y)
  self.last = os.time()
end

return Clutterer