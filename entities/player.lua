-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"
local utils = require "utils"

-- Define the class (and constructor).
local Player = Class(function(self, image)
   self.image = image
   self.theta = 3 * math.pi / 2
   self.RADIUS = constants.PLAYER_DISTANCE
   self.SIZE = constants.PLAYER_SIZE
   self.SPIN_RATE = constants.PLAYER_SPIN_RATE
   self.position = utils.polarToCartesian(self.theta, self.RADIUS)
end)

function Player:update(dt)
   if love.keyboard.isDown("a") then
      self.theta = self.theta - self.SPIN_RATE * dt
   end
   if love.keyboard.isDown("d") then
      self.theta = self.theta + self.SPIN_RATE * dt
   end
   self.position = utils.polarToCartesian(self.RADIUS, self.theta)
end

function Player:draw()
   love.graphics.draw(self.image,
      (constants.SCREEN.x / 2) + self.position.x, (constants.SCREEN.y / 2) + self.position.y,
      self.theta + math.pi / 2,
      1, 1,
      self.SIZE.x / 2, self.SIZE.y)
end

-- Used for idiomatic module loading.
return Player
