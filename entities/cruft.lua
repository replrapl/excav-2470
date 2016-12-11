Cruft = {}

function Cruft:new(x, y)
  newObj = {
    x = x,
    y = y,
    image = love.graphics.newImage('assets/bin/cruft.png')
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Cruft:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

return Cruft