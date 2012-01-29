-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local JetTrail = Class(function(self, image, plane)
   self.image = image
   self.plane = plane
   self.particles = love.graphics.newParticleSystem(self.image, 750)
   self.particles:setEmissionRate(750 * math.abs(plane.thetaSpeed))
   self.particles:setSize(0.3, 0.2, 0.5)
   self.particles:setColor(62, 62, 62, 255, 152, 152, 152, 0)
   self.particles:setPosition(300, 300)
   self.particles:setLifetime(-1)
   self.particles:setParticleLife(0.4)
   self.particles:start()
end)

function JetTrail:update(dt)
   local location = constants.CENTER + self.plane.position
   self.particles:setPosition(location.x, location.y)
   self.particles:update(dt)
end

function JetTrail:draw()
   local color_mode = love.graphics.getColorMode()
   local blend_mode = love.graphics.getBlendMode()
   love.graphics.setColorMode("modulate")
   love.graphics.setBlendMode("additive")
   love.graphics.draw(self.particles, 0, 0)
   love.graphics.setColorMode(color_mode)
   love.graphics.setBlendMode(blend_mode)
end

-- Used for idiomatic module loading.
return JetTrail
