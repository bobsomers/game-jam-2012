-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local JetTrail = require "fx/jet_trail.lua"
local constants = require "constants"
local utils = require "utils"

-- Define the class (and constructor).
--
-- @param   image       already loaded image to use for the plane
-- @param   r           how far the plane should start from the center, in px
-- @param   theta       the angle, in radians
-- @param   rSpeed      the radial speed of descent
-- @param   thetaSpeed  the angular speed at which the plane travels (+ is ccw)
local Plane = Class(function(self, image, particleImage, r, theta, rSpeed, thetaSpeed)
   self.image = image
   -- Generate a random color for this enemy
   self.color = constants.ENEMY_COLORS[math.random(1,4)];
   self.r = r
   self.theta = theta
   self.rSpeed = rSpeed
   self.thetaSpeed = thetaSpeed
   self.health = constants.PLANE_HEALTH
   self.position = utils.polarToCartesian(self.r, self.theta)
   self.trail = JetTrail(particleImage, self)
   numPlanes = numPlanes + 1
end)

function Plane:update(dt)
   -- Update the radius and theta
   self.r = self.r + (dt * self.rSpeed)
   self.theta = self.theta + (dt * self.thetaSpeed)
   self.position = utils.polarToCartesian(self.r, self.theta)
   self.trail:update(dt)
end

function Plane:draw()
   self.trail:draw()

   -- We'll "scale" our image on the Y axis by either +1 or -1, depending on
   -- which way the plane needs to be facing to look in his direction of travel.
   local facing = 1
   if self.thetaSpeed < 0 then
      facing = -1
   end

   local centerX = constants.SCREEN.x / 2
   local centerY = constants.SCREEN.y / 2

   local drawX = centerX + self.position.x
   local drawY = centerY + self.position.y

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
end

-- What happens when a plane is shot by a bullet?
-- Return true if the plane was destroyed by this bullet, false otherwise.
function Plane:getShot(bullet)
   -- If the colors match up, then apply more damage
   if (self.color == bullet.color) then
      self.health = self.health - constants.BULLET_MATCHING_COLOR_DAMAGE
   else
      self.health = self.health - constants.BULLET_NOT_MATCHING_COLOR_DAMAGE
   end
   -- Return true if the plane died from this shot
   if (self.health <= 0) then
      -- Destroy the plane and let the play state know that the ship was destroyed.
      self:destroy()
      return true
   end
   -- Otherwise return false
   return false
end

function Plane:destroy()
   numPlanes = numPlanes - 1
   numPlanesToHave = numPlanesToHave -1
   self.trail = nil
end

function Plane:crashIntoSnake()
   self:destroy()
   constants.SNAKE_CURRENT_HEALTH = constants.SNAKE_CURRENT_HEALTH - 20
end

-- Used for idiomatic module loading.
return Plane
