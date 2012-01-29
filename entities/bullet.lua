-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class and constructor.
local Bullet = Class(function(self, images, position, direction, color)
   self.time = 0
   self.images = images
   self.position = position
   self.direction = direction
   self.color = color
   self.speed = constants.BULLET_SPEED
   self.SIZE = constants.BULLET_SIZE
   self.rotation = math.atan2(self.direction.y, self.direction.x) + math.pi / 2
end)

function Bullet:update(dt)
   self.time = self.time + dt
   self.position.x = self.position.x + self.direction.x * self.speed * dt
   self.position.y = self.position.y + self.direction.y * self.speed * dt
end

function Bullet:draw()
   -- TODO: make these constants somewhere?
   if self.color == "red" then
      love.graphics.setColor(255, 100, 100, 255)
   elseif self.color == "blue" then
      love.graphics.setColor(150, 150, 255, 255)
   elseif self.color == "yellow" then
      love.graphics.setColor(255, 255, 0, 255)
   elseif self.color == "green" then
      love.graphics.setColor(0, 255, 0, 255)
   end

   local image = self.images[math.floor(self.time * 30) % 2 + 1]

   love.graphics.draw(image,
      self.position.x, self.position.y,
      self.rotation,
      1, 1,
      self.SIZE.x / 2, self.SIZE.y / 2)

   -- Reset the tint so only the bullet is affected
   love.graphics.setColor(255, 255, 255, 255)
end

-- Used for idiomatic module loading.
return Bullet
