require('../utils/trace')

Ground = {}

function Ground:new(world, x, y, width, height)
  body = love.physics.newBody(world, x, y, 'static')
  shape = love.physics.newRectangleShape(width, height)
  fixture = love.physics.newFixture(body, shape)

  newObj = {
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

function Ground:draw()
  love.graphics.setColor(188, 106, 83)
  love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
end

return Ground