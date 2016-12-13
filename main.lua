require('utils/trace')

local Robot = require('entities/robot')
local Dog = require('entities/dog')
local Cat = require('entities/cat')
local Block = require('entities/block')
local Background = require('entities/background')
local Ground = require('entities/ground')
local Wall = require('entities/wall')
local Collision = require('collision')
local Clutterer = require('clutterer')
local Trailer = require('trailer')

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
    size = 5,
    colors = {
      {
        red = 196,
        green = 88,
        blue = 24
      },
      {
        red = 180,
        green = 88,
        blue = 24
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

  rosie = Robot:new(world, 250, 250, 50, 50)
  dog = Dog:new(world, 350, 350, 50, 50)
  cat = Cat:new(world, 100, 500, 50, 50)
  
  ceiling = Wall:new(world, 325, 1, 650, 1)
  ground = Wall:new(world, 325, 649, 650, 1)
  leftWall = Wall:new(world, 1, 325, 1, 650)
  rightWall = Wall:new(world, 649, 325, 1, 650)

  -- Clutter makes clutter.
  clutterer = Clutterer:new(width, height)
  clutter = {}

  trailer = Trailer:new(100, 100)

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
    local position = rosie:getPosition()
    trailer:spawn(position.x, position.y)
    rosie:drive(100)
  end
  if love.keyboard.isDown("s") then
    rosie:drive(-100)
  end

  if love.keyboard.isDown("s") == false and love.keyboard.isDown("w") == false and love.keyboard.isDown("a") == false and love.keyboard.isDown("d") == false then
    rosie:stop()
  end

  if clutterer:shouldSpawn(#clutter) then
    clutter[#clutter + 1] = clutterer:spawn()
  end

  if dog:spaz() then 
     dog:move(math.random(-9000, 9000), math.random(-9000, 9000))
  end

  if cat:spaz() then 
     cat:move(math.random(-9000, 9000), math.random(-9000, 9000))
  end
end

function love.draw()
  background:draw()

  -- Clutter to draw.
  for i = #clutterer.clutter, 1, -1 do
    cruft = clutterer.clutter[i]
    sucked = rosie:suck(cruft)
    if sucked == true then
      clutterer:remove(i)
    else
      cruft:draw()
    end
  end

    -- Clutter to draw.
  for i = #trailer.trails, 1, -1 do
    trail = trailer.trails[i]
    if trail:isFaded() then
      trailer:remove(i)
    else
      trail:draw()
    end
  end

  rosie:draw()
  dog:draw()
  cat:draw()

  ceiling:draw()
  ground:draw()
  leftWall:draw()
  rightWall:draw()

  -- Debug info.
  love.graphics.print("Current Score: "..tostring(rosie.score), 10, 10)

  -- Logger
  trace.draw(16, 40)
end
