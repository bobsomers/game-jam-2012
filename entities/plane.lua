-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"
local utils = require "utils"

-- Define the class (and constructor).
--
-- @param   image       already loaded image to use for the plane
-- @param   color       color of the plane
-- @param   r           how far the plane should start from the center, in px
-- @param   theta       the angle, in radians
-- @param   rSpeed      the radial speed of descent
-- @param   thetaSpeed  the angular speed at which the plane travels (+ is ccw)
local Plane = Class(function(self, image, color, r, theta, rSpeed, thetaSpeed)
   self.image = image
   self.color = color
   self.r = r
   self.theta = theta
   self.rSpeed = rSpeed
   self.thetaSpeed = thetaSpeed
   self.health = constants.PLANE_HEALTH
end)

function Plane:update(dt)
   -- Update the radius and theta
   self.r = self.r + (dt * self.rSpeed)
   self.theta = self.theta + (dt * self.thetaSpeed)
end

function Plane:draw()
   local coordinates = utils.polarToCartesian(self.r, self.theta)

   -- We'll "scale" our image on the Y axis by either +1 or -1, depending on
   -- which way the plane needs to be facing to look in his direction of travel.
   local facing = 1
   if self.thetaSpeed < 0 then
      facing = -1
   end

   -- TODO: REPLACE THESE CONSTANTS
   local centerX = constants.SCREEN.x / 2
   local centerY = constants.SCREEN.y / 2

   local drawX = centerX + coordinates.x
   local drawY = centerY + coordinates.y

   local scale = 0.1

   -- Draw the plane at position (coordinate.x, coordinate.y) with no rotation,
   -- 1.0 scale on the X axis and "facing" scale on the Y axis, 
   -- and defining the center of our plane to be in the center of the image.
   --(image, x, y, rotation, scaleX, scaleY, originOffsetX, originOffsetY)
   love.graphics.draw(self.image,
      drawX, drawY,
      self.theta,
      scale, scale * facing,
      self.image:getWidth() / 2, self.image:getHeight() / 2)

   --[[
   -- Draw the enemy at position (x, y) with no rotation, 1.0 scale on the Y
   -- axis and "facing" scale on the X axis, and defining the center of our
   -- enemy to be in the center of the image.
   love.graphics.draw(self.images[self.level],
   self.position.x, self.position.y,
   0,
   facing, 1,
   self.images[self.level]:getWidth() / 2, self.images[self.level]:getHeight() / 2)
   ]]
end

-- Used for idiomatic module loading.
return Plane