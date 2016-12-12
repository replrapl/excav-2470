Robot = {}

function Robot:new(world, x, y)
  local width = 100
  local height = 100
  local body = love.physics.newBody(world, x, y, "dynamic")
  body:setFixedRotation(true)
  local shape = love.physics.newRectangleShape(width, height)
  local fixture = love.physics.newFixture(body, shape)
  fixture:setRestitution(0)
  local image = love.graphics.newImage('assets/bin/zoomba.png')
  local scale = 1

  local newObj = {
    x = x,
    y = y,
    width = width,
    height = height,
    body = body,
    shape = shape,
    fixture = fixture,
    image = image,
    scale = .75
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
  love.graphics.draw(self.image, self.x, self.y, self.body:getAngle(), self.scale, self.scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function Robot:suck(dust)
    if distanceTo(self.x, self.y, dust.x, dust.y) < 50 then
        return true
    end
    return false
end

function Robot:getPosition()
    return {x = self.body:getX(), y = self.body:getY() }
end

function distanceTo(x1, y1, x2, y2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

return Robot
