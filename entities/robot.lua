Robot = {}

function Robot:new(world, x, y, width, height)
  body = love.physics.newBody(world, x, y, "dynamic")
  body:setFixedRotation(true)
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

function Robot:drive(velocity)
    local angle = self.body:getAngle()
    self.body:setLinearVelocity(math.cos(- angle + math.pi / 2) * velocity, - math.sin(- angle + math.pi / 2) * velocity)
end

function Robot:rotate(angle)
    self.body:setAngle(self.body:getAngle() + angle)
end

function Robot:stop()
    self.body:setLinearVelocity(0, 0)
end

function Robot:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

return Robot
