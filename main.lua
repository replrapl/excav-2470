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
  love.window.setTitle('BlickBlock')

  background = Background:new(0, 0, {
    size = 25,
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

  block = Block:new(world, 25, 25, 50, 50)
  block2 = Block:new(world, 225, 25, 50, 50)

  ground = Ground:new(world, 325, 649, 650, 1)
  leftWall = Wall:new(world, 1, 325, 1, 650)
  rightWall = Wall:new(world, 649, 325, 1, 650)
end

function love.update(dt)
  world:update(dt)

  if alpha == 255 then
    alphaIncrementer = -1
  elseif alpha == 0 then
    alphaIncrementer = 1
  end

  alpha = alpha + alphaMultiplier * alphaIncrementer

  if love.keyboard.isDown("d") then
    block.body:applyForce(400, 0)
  end
  if love.keyboard.isDown("a") then
    block.body:applyForce(-400, 0)
  end
  if love.keyboard.isDown("w") then
    block.body:applyForce(0, -400)
  end
  if love.keyboard.isDown("s") then
    block.body:applyForce(0, 400)
  end
end

function love.draw()
  love.graphics.setColor(102, 20, 99, 255)
  love.graphics.print(alpha, 20, 20)

  love.graphics.setColor(220, 6, 217, alpha)
  love.graphics.print("BlickBlock", 300, 200, 0, 1.5, 1.5)

  background:draw()
  block:draw()
  block2:draw()

  ground:draw()
  leftWall:draw()
  rightWall:draw()

  trace.draw()
end
