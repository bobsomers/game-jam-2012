-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class and constructor.
local Bullet = Class(function(self, image, position, direction)
   self.image = image
   self.position = position
   self.direction = direction
   self.speed = constants.BULLET_SPEED
   self.SIZE = constants.BULLET_SIZE
   self.rotation = math.atan2(self.direction.y, self.direction.x) + math.pi / 2
end)

function Bullet:update(dt)
   self.position.x = self.position.x + self.direction.x * self.speed * dt
   self.position.y = self.position.y + self.direction.y * self.speed * dt
end

function Bullet:draw()
   love.graphics.draw(self.image,
      self.position.x, self.position.y,
      self.rotation,
      1, 1,
      self.image:getWidth() / 2, self.image:getHeight() / 2)
end

-- Used for idiomatic module loading.
return Bullet
