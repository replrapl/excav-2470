require('utils/trace')

local Robot = require('entities/robot')
local Block = require('entities/block')
local Background = require('entities/background')
local Ground = require('entities/ground')
local Wall = require('entities/wall')
local Collision = require('collision')
local Clutterer = require('clutterer')

math.randomseed(os.time())

function love.load()
  love.graphics.setBackgroundColor(63, 63, 63)
  trace.print('Trace initialized.', trace.styles.green)

  alpha = 0
  alphaIncrementer = 1
  alphaMultiplier = 3
  width = 650
  height = 650

  -- Initialize our world
  world = love.physics.newWorld(0, 50, true)
  world.setCallbacks(world, Collision.beginContact, Collision.endContact, Collision.preSolve, Collision.postSolve)

  love.window.setMode(width, height) -- set options for our window
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

  rosie = Robot:new(world, 250, 250, 50, 80)
  block2 = Block:new(world, 350, 250, 50, 50)

  ceiling = Wall:new(world, 325, 1, 650, 1)
  ground = Wall:new(world, 325, 649, 650, 1)
  leftWall = Wall:new(world, 1, 325, 1, 650)
  rightWall = Wall:new(world, 649, 325, 1, 650)

  -- Clutter makes clutter.
  clutterer = Clutterer:new(width, height)

  -- Track cruft, which spawn randomly.
  clutter = {}

  -- Set gravity so we don't all fall off :('
  world:setGravity(0, 0)
end

function love.update(dt)
  world:update(dt)

  if love.keyboard.isDown("d") then
    rosie:rotate(0.1)
  end
  if love.keyboard.isDown("a") then
    rosie:rotate(-0.1)
  end
  if love.keyboard.isDown("w") then
    rosie:drive(100)
  end
  if love.keyboard.isDown("s") then
    rosie:drive(-100)
  end

  if love.keyboard.isDown("s") == false and love.keyboard.isDown("w") == false then
    rosie:stop()
  end

  if clutterer.shouldSpawn() then
    table.insert(clutter, clutterer:spawn())
  end
end

function love.draw()
  love.graphics.setColor(220, 6, 217, 255)
  love.graphics.print("BlickBlock", 300, 200, 0, 1.5, 1.5)

  background:draw()
  rosie:draw()
  block2:draw()

  ceiling:draw()
  ground:draw()
  leftWall:draw()
  rightWall:draw()
  
  -- Clutter to draw.
  for i = 1, #clutter do
    cruft = clutter[i]
    cruft:draw()
  end

  -- Debug info.
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)

  -- Logger
  trace.draw(16, 40)
end
