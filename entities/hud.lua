
local Class = require "hump.class"
local constants = require "constants"

local Hud = Class(function()
end)

function Hud:load()
end

function Hud:update(dt)
end

function Hud:draw(snakehealth, score)
   --score = 300
   love.graphics.setColor(0,255,0)
   love.graphics.rectangle("fill" , 0, constants.SCREEN.y-100, constants.SCREEN.x, 100)
   tLevel = constants.SCREEN.y-50   --text level, the y level for the text
   love.graphics.setColor(0,0,0);
   love.graphics.printf("Score: "..score, 100, tLevel, 600, "left");
   love.graphics.setColor(255,255,255)
end

-- idiomatic module loadinf
return Hud
