-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local Snake = Class(function(self, image)
   self.image = image
   self.position = Vector(constants.SCREEN.x / 2, constants.SCREEN.y / 2)
   self.rotation = 0
   -- Reset the snake's health to its max.
   constants.SNAKE_CURRENTH_HEALTH = constants.MAX_SNAKE_HEALTH
end)

function Snake:update(dt)
   -- Replaced with mousewheel
   --if love.keyboard.isDown("left") then
   --   self:spinCCW(dt)
   --end
   --if love.keyboard.isDown("right") then
   --   self:spinCW(dt)
   --end
end

function Snake:draw()
   love.graphics.draw(self.image,
      self.position.x, self.position.y,
      self.rotation,
      1, 1,
      self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function Snake:spinCW()
   self.rotation = (self.rotation + constants.SNAKE_SPIN_RATE)
end

function Snake:spinCCW()
   self.rotation = (self.rotation - constants.SNAKE_SPIN_RATE)
end

function Snake:getCurrentColor(playerRotation)
   -- Rotations between -2pi and 2pi
   local playerRotationNormal = playerRotation % (math.pi * 2)
   local snakeRotationNormal = self.rotation % (math.pi * 2)

   if playerRotationNormal < 0 then
      playerRotationNormal = playerRotationNormal + (math.pi * 2)
   end

   if snakeRotationNormal < 0 then
      snakeRotationNormal = snakeRotationNormal + (math.pi * 2)
   end
   -- Rotations around 0 and 2pi

   -- Position of player in respect to the snake (-2pi to 2pi)
   local difference = playerRotationNormal - snakeRotationNormal

   if difference < 0 then
      difference = difference + (math.pi * 2)
   end
   -- Now from 0 to 2pi

   -- Now from 0 to 1.0
   local percentage = difference / (math.pi * 2)
   local section = percentage * #constants.ENEMY_COLORS

   return constants.ENEMY_COLORS[math.ceil(section)]
end

-- Replaced with other ones for mousewheel
--function Snake:spinCW(dt)
--   self.rotation = self.rotation + self.SPIN_RATE * dt
--end
--
--function Snake:spinCCW(dt)
--   self.rotation = self.rotation - self.SPIN_RATE * dt
--end

-- Used for idiomatic module loading.
return Snake
