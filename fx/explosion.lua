-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local Explosion = Class(function(self, image, position)
   self.image = image
   self.position = position
   self.duration = 0
   self.active = true

   self.fire = love.graphics.newParticleSystem(self.image, 500)
   self.fire:setEmissionRate(1000)
   self.fire:setSize(1, 1.5, 1)
   self.fire:setSpeed(500, 700)
   self.fire:setColor(220, 105, 20, 255, 194, 30, 18, 0)
   self.fire:setPosition(position.x, position.y)
   self.fire:setLifetime(0.15)
   self.fire:setParticleLife(0.2)
   self.fire:setSpread(2 * math.pi)
   self.fire:setTangentialAcceleration(1000)
   self.fire:setRadialAcceleration(-2000)

   self.smoke = love.graphics.newParticleSystem(self.image, 400)
   self.smoke:setEmissionRate(1000)
   self.smoke:setSize(2, 4, 1)
   self.smoke:setSpeed(400, 500)
   self.smoke:setRadialAcceleration(-180)
   self.smoke:setColor(62, 62, 62, 50, 152, 152, 152, 0)
   self.smoke:setPosition(position.x, position.y)
   self.smoke:setLifetime(0.3)
   self.smoke:setParticleLife(3)
   self.smoke:setSpread(2 * math.pi)

   self.fire:start()
   self.smoke:start()
end)

function Explosion:update(dt)
   self.fire:update(dt)
   self.smoke:update(dt)
   self.duration = self.duration + dt
   if self.duration > 4 then
      self.active = false
   end
end

function Explosion:draw()
   local color_mode = love.graphics.getColorMode()
   local blend_mode = love.graphics.getBlendMode()
   love.graphics.setColorMode("modulate")
   love.graphics.setBlendMode("additive")
   love.graphics.draw(self.smoke, 0, 0)
   love.graphics.draw(self.fire, 0, 0)
   love.graphics.setColorMode(color_mode)
   love.graphics.setBlendMode(blend_mode)
end

-- Used for idiomatic module loading.
return Explosion
