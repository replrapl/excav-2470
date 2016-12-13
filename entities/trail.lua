Trail = {}

function Trail:new(x, y)
  local newObj = {
    x = x,
    y = y,
    image = love.graphics.newImage('assets/bin/cruft.png'),
    offset = 0,
    scale = 1,
    alpha = 70,
    rotation = math.random(0, 2 * math.pi),
    age = 0
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Trail:draw()
  love.graphics.setColor(40, 40, 40, self.alpha)
  love.graphics.draw(self.image, self.x, self.y, self.rotation, 3, 3, self.image:getWidth() / 2, self.image:getHeight() / 2)
  self.alpha = self.alpha - 0.7
  self.age = self.age + 1
end

function Trail:isFaded()
    return self.age > 100
end

return Trail