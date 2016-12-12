Dog = {}

function Dog:new(world, x, y, width, height)
  image = love.graphics.newImage('assets/src/dog.png')
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
    fixture = fixture,
    threshold = 0.2,
    last = os.time() - 2,
    image = image
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Dog:draw()
  love.graphics.draw(self.image, self.body:getX() - self.image:getWidth() / 2, self.body:getY() - self.image:getHeight() / 2, self.body:getAngle(), 0.7, 0.7, 0, 0)
end

function Dog:move(x, y)
    self.body:applyForce(x, y)
end

function Dog:spaz()
    trace.print(tostring(self:thresholdMet()))
    if self:thresholdMet() then
        self.last = os.time()
        return true
    end
    return false
end

function Dog:thresholdMet()
    return os.difftime(os.time(), self.last) > self.threshold
end

return Dog
