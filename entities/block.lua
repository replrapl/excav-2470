Block = {}

function Block:new(world, x, y, width, height)
  body = love.physics.newBody(world, x, y, "dynamic")
  shape = love.physics.newRectangleShape(width, height)
  fixture = love.physics.newFixture(body, shape)
  fixture:setRestitution(0)

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

function Block:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

return Block
