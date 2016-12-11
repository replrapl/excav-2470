Package = {}

function Package:new(x, y, params)
  newObj = {
    x = x,
    y = y,
  }
end

function Package:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.