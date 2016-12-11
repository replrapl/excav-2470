require('utils/trace')

local Block = require('entities/block')
local Background = require('entities/background')
local Ground = require('entities/ground')
local Wall = require('entities/wall')
local Collision = require('collision')

math.randomseed(os.time())

function love.load()
  love.graphics.setBackgroundColor(63, 63, 63)
  trace.print('Trace initialized.', trace.styles.green)

  alpha = 0
  alphaIncrementer = 1
  alphaMultiplier = 3

  -- Initialize our world
  world = love.physics.newWorld(0, 50, true)
  world.setCallbacks(world, Collision.beginContact, Collision.endContact, Collision.preSolve, Collision.postSolve)

  love.window.setMode(650, 650) -- set options for our window
  love.window.setTitle('ZoombaTron!')

  background = Background:new(0, 0, {
    size = 1,
    colors = {
      {
        red = 22,
        green = 66,
        blue = 194
      },
      {
        red = 128,
        green = 86,
        blue = 196
      },
      {
        red = 128,
        green = 43,
        blue = 170
      }
    },
    alpha = 1,
    fill = {
      color = {
        red = 28,
        green = 27,
        blue = 41
      },
      alpha = 1
    },
    maxHeight = 650,
    maxWidth = 650
  })
  background:build()
  background:drawCanvas()

  block = Block:new(world, 25, 25, 50, 50)
  block.body:setFixedRotation(true)
  block2 = Block:new(world, 225, 25, 50, 50)

  ceiling = Wall:new(world, 325, 1, 650, 1)
  ground = Wall:new(world, 325, 649, 650, 1)
  leftWall = Wall:new(world, 1, 325, 1, 650)
  rightWall = Wall:new(world, 649, 325, 1, 650)

  world:setGravity(0, 0)
end

function love.update(dt)
  world:update(dt)

  if love.keyboard.isDown("d") then
    block.body:setAngle(block.body:getAngle() + 0.1)
  end
  if love.keyboard.isDown("a") then
    block.body:setAngle(block.body:getAngle() - 0.1)
  end
  if love.keyboard.isDown("w") then
    local a = block.body:getAngle()
    block.body:setLinearVelocity(math.cos(- a + math.pi / 2) * 100, - math.sin(- a + math.pi / 2) * 100)
  end
  if love.keyboard.isDown("s") then
    local a = block.body:getAngle()
    block.body:setLinearVelocity(- math.cos(- a + math.pi / 2) * 100, math.sin(- a + math.pi / 2) * 100)
  end

  if love.keyboard.isDown("s") == false and love.keyboard.isDown("w") == false then
    block.body:setLinearVelocity(0, 0)
  end
end

function love.draw()
  love.graphics.setColor(220, 6, 217, 255)
  love.graphics.print("BlickBlock", 300, 200, 0, 1.5, 1.5)

  background:draw()
  block:draw()
  block2:draw()

  ceiling:draw()
  ground:draw()
  leftWall:draw()
  rightWall:draw()

  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
  trace.draw(16, 40)
end
