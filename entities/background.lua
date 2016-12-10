Background = {}

function Background:new(x, y, params)
  newObj = {
    x = x,
    y = y,
    size = params.size,
    colors = params.colors,
    alpha = params.alpha,
    fillColor = params.fill.color,
    fillAlpha = params.fill.alpha,
    fill = params.fill,
    maxWidth = params.maxWidth,
    maxHeight = params.maxHeight,
    rows = {}
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Background:build()
  local rows = 0
  while rows * self.size < self.maxHeight do
    local columns = 0
    self.rows[rows + 1] = {}

    while columns * self.size < self.maxWidth do
      local xOffset = 0
      local yOffset = 0

      if columns ~= 0 then
        xOffset = columns * self.size
      end

      if rows ~= 0 then
        yOffset = rows * self.size
      end

      -- Draw box
      local color = self.colors[math.random(#self.colors)]
      self.rows[rows + 1][columns + 1] = {
        color = color,
        x = xOffset,
        y = yOffset
      }
      -- Increment column counter
      columns = columns + 1
    end
    rows = rows + 1
  end
end

function Background:draw()
  for i = 1, #self.rows do
    for j = 1, #self.rows[i] do
      column = self.rows[i][j]
      love.graphics.setColor(column.color.red, column.color.green, column.color.blue)
      love.graphics.rectangle('fill', column.x, column.y, self.size, self.size)
    end
  end
end

return Background