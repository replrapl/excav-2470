require('../utils/trace')

Wall = {}

function Wall:new(world, x, y, width, height)
  local body = love.physics.newBody(world, x, y, 'static')
  local shape = love.physics.newRectangleShape(width, height)
  local fixture = love.physics.newFixture(body, shape)

  local newObj = {
    x = x,
    y = y,
    width = width,
    height = height,
    body = body,
    shape = shape,
    fixture = fixture
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Wall:draw()
  love.graphics.setColor(188, 106, 83)
  love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
end

return Wall