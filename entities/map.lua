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
    tileWidth = tileWidth,
    tileHeight = tileHeight,
  }

  self.__index = self
  return setmetatable(newObj, self)
end

function Map:moveCameraUp()
  if self.cameraY > 0 then
    self.cameraY = self.cameraY - 1 * self.cameraMovementMultiplier
  end
end

function Map:moveCameraDown()
  if self.cameraY + self.cameraHeight < self.mapH then
    self.cameraY = self.cameraY + 1 * self.cameraMovementMultiplier
  end
end

function Map:moveCameraLeft()
  if self.cameraX > 0 then
    self.cameraX = self.cameraX - 1 * self.cameraMovementMultiplier
  end
end

function Map:moveCameraRight()
  if self.cameraX + self.cameraWidth < self.mapW then
    self.cameraX = self.cameraX + 1 * self.cameraMovementMultiplier
  end
end

function Map:draw()
  -- The starting/ending tiles.
  local firstXTile = math.floor(self.cameraX/self.tileWidth) + 1
  local lastXTile = math.floor((self.cameraX+self.cameraWidth)/self.tileWidth) + 1
  local firstYTile = math.floor(self.cameraY/self.tileHeight) + 1
  local lastYTile = math.floor((self.cameraY+self.cameraHeight)/self.tileHeight) + 1

  local xOffset = self.cameraX - (firstXTile - 1) * self.tileWidth
  local yOffset = self.cameraY - (firstYTile - 1) * self.tileHeight

  for y = firstYTile, lastYTile do
    for x = firstXTile, lastXTile do
      xPos = (x - 1) * self.tileWidth - xOffset
      yPos = (y - 1) * self.tileHeight - yOffset
      love.graphics.draw(self.tiles[self.map[y][x]], xPos, yPos)
    end
  end
end

return Map
