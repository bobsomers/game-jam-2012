-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local Explosion = Class(function(self, image, position, color)
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
   self.fire:setLifetime(0.2)
   self.fire:setParticleLife(0.2)
   self.fire:setSpread(2 * math.pi)
   self.fire:setTangentialAcceleration(1000)
   self.fire:setRadialAcceleration(-2000)

   self.shockwave = love.graphics.newParticleSystem(self.image, 500)
   self.shockwave:setEmissionRate(4000)
   self.shockwave:setSize(0.5, 0.75, 1)
   self.shockwave:setSpeed(constants.CHAIN_WAVE_GROWTH_RATE)
   if color == "red" then
      self.shockwave:setColor(200, 0, 0, 128, 128, 0, 0, 0)
   elseif color == "green" then
      self.shockwave:setColor(0, 200, 0, 128, 0, 128, 0, 0)
   elseif color == "blue" then
      self.shockwave:setColor(100, 100, 255, 128, 50, 50, 128, 0)
   elseif color == "yellow" then
      self.shockwave:setColor(200, 200, 0, 128, 128, 128, 0, 0)
   end
   self.shockwave:setPosition(position.x, position.y)
   self.shockwave:setLifetime(0.1)
   self.shockwave:setParticleLife(1)
   self.shockwave:setSpread(2 * math.pi)

   self.fire:start()
   self.shockwave:start()
end)

function Explosion:update(dt)
   self.fire:update(dt)
   self.shockwave:update(dt)
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
   love.graphics.draw(self.shockwave, 0, 0)
   love.graphics.draw(self.fire, 0, 0)
   love.graphics.setColorMode(color_mode)
   love.graphics.setBlendMode(blend_mode)
end

-- Used for idiomatic module loading.
return Explosion
