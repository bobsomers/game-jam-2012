local Class = require "hump.class"
local constants = require "constants"

local Hud = Class(function(self)
   self.images = {
      left = love.graphics.newImage("Assets/HUDbox_left.png"),
      right = love.graphics.newImage("Assets/HUDbox_right.png")
   }
   self.fonts = {
      title = love.graphics.newFont("Assets/Defused.ttf", 24),
      score = love.graphics.newFont("Assets/WhiteRabbit.ttf", 56)
   }
end)

function Hud:update(dt)
end

function Hud:draw(snakehealth, score)
   love.graphics.draw(self.images.left, 0, constants.SCREEN.y - 100)
   love.graphics.draw(self.images.right,
      constants.SCREEN.x - 300, constants.SCREEN.y - 100)

   love.graphics.setFont(self.fonts.title)
   love.graphics.setColor(255, 255, 255)

   love.graphics.print("SCORE", 65, constants.SCREEN.y - 80)
   love.graphics.print("HEALTH", constants.SCREEN.x - 175, constants.SCREEN.y - 80)

   love.graphics.setFont(self.fonts.score)

   love.graphics.print(string.format("%06d", score), 50, constants.SCREEN.y - 45)
end

-- idiomatic module loadinf
return Hud
