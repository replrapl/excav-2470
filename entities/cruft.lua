Cruft = {}

function Cruft:new(x, y)
  newObj = {
    x = x,
    y = y,
    image = love.graphics.newImage('assets/bin/blarg.png'),
    offset = math.random(0, 2*math.pi), -- offset in radians
    scale = math.random(1, 2)
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Cruft:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.image, self.x, self.y, self.offset, self.scale)
end

return Cruft