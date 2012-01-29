-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"
local utils = require "utils"
local sound = require "sound"

-- Define the class (and constructor).
local Player = Class(function(self, images)
   self.images = images
   self.theta = 3 * math.pi / 2
   self.RADIUS = constants.PLAYER_DISTANCE
   self.SIZE = constants.PLAYER_SIZE
   self.SPIN_RATE = constants.PLAYER_SPIN_RATE
   self.position = utils.polarToCartesian(self.theta, self.RADIUS)
   self.moving = false
   self.time = 0
   self.facing = 1
end)

function Player:update(dt)
   self.time = self.time + dt
   self.moving = false
   if love.keyboard.isDown("a") then
      self.theta = self.theta - self.SPIN_RATE * dt
      self.moving = true
      self.facing = 1
   end
   if love.keyboard.isDown("d") then
      self.theta = self.theta + self.SPIN_RATE * dt
      self.moving = true
      self.facing = -1
   end
   self.position = utils.polarToCartesian(self.RADIUS, self.theta)

   if self.moving then
      sound.walk(dt)
   end
end

function Player:draw()
   local image = {}
   if self.moving then
      image = self.images.run[math.floor(self.time * 5) % 2 + 1]
   else
      image = self.images.stand[math.floor(self.time * 5) % 2 + 1]
   end

   love.graphics.draw(image,
      (constants.SCREEN.x / 2) + self.position.x, (constants.SCREEN.y / 2) + self.position.y,
      self.theta + math.pi / 2,
      self.facing, 1,
      self.SIZE.x / 2, self.SIZE.y)
end

-- Used for idiomatic module loading.
return Player
