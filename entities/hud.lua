
local Class = require "hump.class"
local constants = require "constants"

local Hud = Class(function()
end)

function Hud:load()
end

function Hud:update(dt)
end

function Hud:draw(snakehealth, score)
   love.graphics.setColor(0,0,0)
   love.graphics.rectangle("fill" , 0, constants.SCREEN.y-100, constants.SCREEN.x, 100)
   tLevel = constants.SCREEN.y-80   --text level, the y level for the text
   love.graphics.setColor(255,255,255);
   love.graphics.print("Score: "..score, 100, tLevel, 0, 2, 2);
   love.graphics.print("Snake Life: "..snakeHealth, 300, tLevel, 0, 2, 2);
  
   love.graphics.setColor(255,255,255) --put graphics back the way you left it
end

-- idiomatic module loadinf
return Hud
