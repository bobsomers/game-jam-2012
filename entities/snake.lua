-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local Snake = Class(function(self, image)
   self.image = image
   self.position = Vector(constants.SCREEN.x / 2, constants.SCREEN.y / 2)
   self.SPIN_RATE = constants.SNAKE_SPIN_RATE
   self.rotation = 0
end)

function Snake:update(dt)
   if love.keyboard.isDown("left") then
      self:spinCCW(dt)
   end
   if love.keyboard.isDown("right") then
      self:spinCW(dt)
   end
end

function Snake:draw()
   love.graphics.draw(self.image,
      self.position.x, self.position.y,
      self.rotation,
      1, 1,
      self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function Snake:spinCW(dt)
   self.rotation = self.rotation + self.SPIN_RATE * dt
end

function Snake:spinCCW(dt)
   self.rotation = self.rotation - self.SPIN_RATE * dt
end

-- Used for idiomatic module loading.
return Snake
