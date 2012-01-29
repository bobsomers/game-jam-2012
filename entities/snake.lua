-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

local life80 = love.graphics.newImage("images/oroborous_life80.png");
local life60 = love.graphics.newImage("images/oroborous_life60.png");
local life40 = love.graphics.newImage("images/oroborous_life40.png");
local life20 = love.graphics.newImage("images/oroborous_life20.png");

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

function Snake:draw(snakeHealth)
   local snakeSize = 0.5
   love.graphics.draw(self.image,
      self.position.x, self.position.y,
      self.rotation,
      snakeSize, snakeSize,
      self.image:getWidth() / 2, self.image:getHeight() / 2)

   if snakeHealth < 81 then
      love.graphics.draw(life80, self.position.x, self.position.y, self.rotation, snakeSize, snakeSize, life80:getWidth()/2, life80:getHeight()/2)   
   end

   if snakeHealth < 61 then
      love.graphics.draw(life60, self.position.x, self.position.y, self.rotation, snakeSize, snakeSize, life60:getWidth()/2, life60:getHeight()/2)   
   end

   if snakeHealth < 41 then
      love.graphics.draw(life40, self.position.x, self.position.y, self.rotation, snakeSize, snakeSize, life40:getWidth()/2, life40:getHeight()/2)   
   end

   if snakeHealth < 21 then
      love.graphics.draw(life20, self.position.x, self.position.y, self.rotation, snakeSize, snakeSize, life20:getWidth()/2, life20:getHeight()/2)   
   end



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
