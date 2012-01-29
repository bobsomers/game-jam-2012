-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local FireJet = Class(function(self, image, position)
   self.image = image
   self.duration = 0
   self.active = true

   self.fire = love.graphics.newParticleSystem(self.image, 250)
   self.fire:setEmissionRate(250)
   self.fire:setSize(1, 2, 1)
   self.fire:setSpeed(500, 700)
   self.fire:setColor(220, 105, 20, 255, 194, 30, 18, 0)
   self.fire:setLifetime(0.3)
   self.fire:setParticleLife(0.4)
   self.fire:setSpread(math.pi / 10)
   self.fire:setTangentialAcceleration(1000)
   self.fire:setRadialAcceleration(-2000)

   local direction = position - constants.CENTER
   local location = position - (direction:normalized() * 20)
   local orientation = math.atan2(direction.y, direction.x)
   self.fire:setPosition(location.x, location.y)
   self.fire:setDirection(orientation)

   self.fire:start()
end)

function FireJet:update(dt)
   self.fire:update(dt)
   self.duration = self.duration + dt
   if self.duration > 1 then
      self.active = false
   end
end

function FireJet:draw()
   local color_mode = love.graphics.getColorMode()
   local blend_mode = love.graphics.getBlendMode()
   love.graphics.setColorMode("modulate")
   love.graphics.setBlendMode("additive")
   love.graphics.draw(self.fire, 0, 0)
   love.graphics.setColorMode(color_mode)
   love.graphics.setBlendMode(blend_mode)
end

-- Used for idiomatic module loading.
return FireJet
