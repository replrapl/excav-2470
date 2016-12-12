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
    self.x, self.y = self.body:getWorldPoints(0, 0)
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

function Robot:suck(dust)
    if distanceTo(self.x, self.y, dust.x, dust.y) < 501 then
        -- trace.print(distanceTo(self.x, self.y, dust.x, dust.y))
        return true
    end
    return false
end

function distanceTo(x1, y1, x2, y2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

return Robot
