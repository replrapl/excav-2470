Map = {}

function Map:new(mapName, cameraX, cameraY, cameraWidth, cameraHeight, offsetX, offsetY)
  local map = require("assets/maps/"..mapName)
  -- map tiles
  tiles = {}
  for i=0,3 do -- change 3 to the number of tile images minus 1.
    tiles[i] = love.graphics.newImage( "assets/maps/tiles/"..i..".png" )
  end

  -- build a shiny new map
  local newObj = {
    tiles = tiles,
    map = map,
    mapW = table.getn(map[1]),
    mapH = table.getn(map),
    mapOffsetX = offsetX,
    mapOffsetY = offsetY,
    cameraX = cameraX,
    cameraY = cameraY,
    cameraWidth = cameraWidth,
    cameraHeight = cameraHeight,
    tileW = 48,
    tileH = 48,
  }
  self.__index = self
  return setmetatable(newObj, self)
end

function Map:draw(cameraX, cameraY)
  for y = 1, self.cameraHeight do
    for x = 1, self.cameraWidth do
      love.graphics.draw(self.tiles[self.map[y + self.cameraY][x + self.cameraX]], x * self.tileW + self.mapOffsetX, y * self.tileH + self.mapOffsetY)
    end
  end
end

return Map
