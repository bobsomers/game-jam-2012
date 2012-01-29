local Class = require "hump.class"
local Vector = require "hump.vector"
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
   self.bar = {
      position = Vector(constants.SCREEN.x - 250, constants.SCREEN.y - 50),
      size = Vector(200, 30)
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

   -- Titles.
   love.graphics.print("SCORE", 65, constants.SCREEN.y - 80)
   love.graphics.print("HEALTH", constants.SCREEN.x - 175, constants.SCREEN.y - 80)

   -- Score.
   love.graphics.setFont(self.fonts.score)
   love.graphics.print(string.format("%06d", score), 50, constants.SCREEN.y - 45)

   -- Heath bar.
   love.graphics.setColor(255, 255, 255)
   love.graphics.rectangle("fill",
      self.bar.position.x, self.bar.position.y,
      3, self.bar.size.y)
   love.graphics.rectangle("fill",
      self.bar.position.x + self.bar.size.x - 3, self.bar.position.y,
      3, self.bar.size.y)
   love.graphics.rectangle("fill",
      self.bar.position.x, self.bar.position.y,
      self.bar.size.x, 3)
   love.graphics.rectangle("fill",
      self.bar.position.x, self.bar.position.y + self.bar.size.y - 3,
      self.bar.size.x, 3)

   local width = (snakehealth / constants.SNAKE_MAX_HEALTH) * (self.bar.size.x - 6)

   love.graphics.setColor(255, 80, 80)
   love.graphics.rectangle("fill",
      self.bar.position.x + 3, self.bar.position.y + 3,
      width, self.bar.size.y - 6)

   love.graphics.setColor(255, 255, 255)
end

-- idiomatic module loadinf
return Hud
