local Trail = require('./entities/trail')

Trailer = {}

-- Constructor
function Trailer:new(width, height)
  newObj = {
    width = width,
    height = height,
    threshold = 100,
    last = os.time(),
    trails = {}
  }
  self.__index = self
  return setmetatable(newObj, self) 
end

-- Remove trail at the given index.
function Trailer:remove(i)
  table.remove(self.trails, i)
end

-- Has the threshold for spawning been met?
function Trailer:thresholdMet()
  return os.difftime(os.time(), self.last) > self.threshold
end

-- Convenience method for spawning.
function Trailer:spawn(x, y)
    table.insert(self.trails, Trail:new(x, y))
end

return Trailer