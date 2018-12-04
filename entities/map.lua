Map = {}

function Map:new(mapName, cameraX, cameraY, cameraWidth, cameraHeight, offsetX, offsetY)
  local map = require("assets/maps/"..mapName)
  -- map tiles
  tiles = {}
  for i=0,3 do -- change 3 to the number of tile images minus 1.
    tiles[i] = love.graphics.newImage( "assets/maps/tiles/"..i..".png" )
  end

  local tileWidth = 48
  local tileHeight = 48

  -- build a shiny new map
  local newObj = {
    tiles = tiles,
    map = map,
    mapW = table.getn(map[1]) * tileWidth,
    mapH = table.getn(map) * tileHeight,
    mapOffsetX = offsetX,
    mapOffsetY = offsetY,
    cameraX = cameraX,
    cameraY = cameraY,
    cameraWidth = cameraWidth,
    cameraHeight = cameraHeight,
    cameraMovementMultiplier = 1,
    maxCameraMovementMultiplier = 5,
    tileWidth = tileWidth,
    tileHeight = tileHeight,
  }

  self.__index = self
  return setmetatable(newObj, self)
end

function Map:moveCameraUp()
  if self.cameraY > 0 then
    local newPos = self.cameraY - 1 * self.cameraMovementMultiplier
    self.cameraY = newPos < 0 and 0 or newPos
  end
end

function Map:moveCameraDown()
  if self.cameraY + self.cameraHeight + 1 < self.mapH then
    local newPos = self.cameraY + 1 * self.cameraMovementMultiplier
    self.cameraY = newPos + self.cameraHeight >= self.mapH and self.mapH - self.cameraHeight - 1 or newPos
  end
end

function Map:moveCameraLeft()
  if self.cameraX > 0 then
    local newPos = self.cameraX - 1 * self.cameraMovementMultiplier
    self.cameraX = newPos < 0 and 0 or newPos
  end
end

function Map:moveCameraRight()
  if self.cameraX + self.cameraWidth + 1 < self.mapW then
    local newPos = self.cameraX + 1 * self.cameraMovementMultiplier
    self.cameraX = newPos + self.cameraWidth > self.mapW and self.mapW - self.cameraWidth - 1 or newPos
  end
end

function Map:increaseCameraMovementSpeed()
  self.cameraMovementMultiplier = self.cameraMovementMultiplier > self.maxCameraMovementMultiplier and self.maxCameraMovementMultiplier or self.cameraMovementMultiplier + 1
end

function Map:decreaseCameraMovementSpeed()
  if self.cameraMovementMultiplier > 1 then
    self.cameraMovementMultiplier = self.cameraMovementMultiplier - 1
  end
end

function Map:draw()
  -- The starting/ending tiles.
  local firstXTile = math.floor(self.cameraX / self.tileWidth)
  local lastXTile = math.floor((self.cameraX + self.cameraWidth)/self.tileWidth)
  local firstYTile = math.floor(self.cameraY / self.tileHeight)
  local lastYTile = math.floor((self.cameraY + self.cameraHeight)/self.tileHeight)
  self.firstXTile = firstXTile
  local xOffset = self.cameraX - (firstXTile * self.tileWidth)
  local yOffset = self.cameraY - (firstYTile * self.tileHeight)

  local yPos = 0
  for y = firstYTile, lastYTile do
    local xPos = 0
    for x = firstXTile, lastXTile do
      love.graphics.draw(self.tiles[self.map[y + 1][x + 1]], xPos - xOffset, yPos - yOffset)
      xPos = xPos + self.tileWidth
    end
    yPos = yPos + self.tileHeight
  end
end

return Map
