-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local Poof = Class(function(self, image, position)
   self.image = image
   self.position = position
   self.duration = 0
   self.active = true

   self.smoke = love.graphics.newParticleSystem(self.image, 100)
   self.smoke:setEmissionRate(300)
   self.smoke:setSize(2, 4, 1)
   self.smoke:setSpeed(100, 200)
   self.smoke:setColor(62, 62, 62, 50, 152, 152, 152, 0)
   self.smoke:setPosition(position.x, position.y)
   self.smoke:setSpread(2 * math.pi)
   self.smoke:setLifetime(0.15)
   self.smoke:setParticleLife(1.5)

   self.smoke:start()
end)

function Poof:update(dt)
   self.smoke:update(dt)
   self.duration = self.duration + dt
   if self.duration > 4 then
      self.active = false
   end
end

function Poof:draw()
   local color_mode = love.graphics.getColorMode()
   local blend_mode = love.graphics.getBlendMode()
   love.graphics.setColorMode("modulate")
   love.graphics.setBlendMode("additive")
   love.graphics.draw(self.smoke, 0, 0)
   love.graphics.setColorMode(color_mode)
   love.graphics.setBlendMode(blend_mode)
end

-- Used for idiomatic module loading.
return Poof
