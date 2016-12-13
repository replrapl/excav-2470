Robot = {}

function Robot:new(world, x, y)
  local radius = 30
  local body = love.physics.newBody(world, x, y, "dynamic")
  body:setFixedRotation(true)
  local shape = love.physics.newCircleShape(radius)--, height)
  local fixture = love.physics.newFixture(body, shape)
  fixture:setRestitution(0)
  local image = love.graphics.newImage('assets/bin/zoomba.png')
  local scale = 1
  local crinkleSound = love.audio.newSource("assets/sound/crinkle.wav", "static")
  local runningVacSound = love.audio.newSource("assets/sound/running_vac.wav", "static")
  local spinningVacSound = love.audio.newSource("assets/sound/running_vac.wav", "static")
  spinningVacSound:setPitch(2)

  local newObj = {
    x = x,
    y = y,
    width = width,
    height = height,
    body = body,
    shape = shape,
    fixture = fixture,
    image = image,
    scale = .75,
    crinkle = crinkleSound,
    runningVacSound = runningVacSound,
    spinningVacSound = spinningVacSound,
    score = 0
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Robot:drive(velocity)
    self.spinningVacSound:stop()
    self.runningVacSound:play()
    local angle = self.body:getAngle()
    self.body:setLinearVelocity(math.cos(- angle + math.pi / 2) * velocity, - math.sin(- angle + math.pi / 2) * velocity)
    self.x, self.y = self.body:getWorldPoints(0, 0)
end

function Robot:rotate(angle)
    self.runningVacSound:play()
    self.body:setAngle(self.body:getAngle() + angle)
    self.spinningVacSound:play()
end

function Robot:stop()
    self.spinningVacSound:stop()
    self.runningVacSound:stop()
    self.body:setLinearVelocity(0, 0)
end

function Robot:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.image, self.x, self.y, self.body:getAngle(), self.scale, self.scale, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function Robot:suck(dust)
    if distanceTo(self.x, self.y, dust.x, dust.y) < 50 then
        self.crinkle:play()
        self.score=self.score+1
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
