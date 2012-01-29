local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"
local Explosion = require "fx.explosion"
local Awesome = require "fx.awesome"

local ChainWave = Class(function(self, font, position, color)
   self.font = font
   self.position = position
   self.color = color
   self.radius = 0
   self.time = 0
   self.active = true
end)

function ChainWave:update(dt, planes, booms, awesomes, chainwaves)
   self.time = self.time + dt
   self.radius = self.time * constants.CHAIN_WAVE_GROWTH_RATE

   for i, plane in ipairs(planes) do
      if plane.color == self.color then
         local plane_position = constants.CENTER + plane.position
         local distance = (self.position - plane_position):len()
         if distance < constants.PLANE_RADIUS + self.radius then
            -- Chain wave caught a plane!
            table.remove(planes, i)
            table.insert(booms, Explosion(booms.image, plane_position))
            multiplier = multiplier + 1
            table.insert(awesomes, Awesome(self.font, multiplier, plane_position))
            table.insert(chainwaves, ChainWave(self.font, plane_position, self.color))
         end
      end
   end

   if self.time > 1 then
      self.active = false
   end
end

function ChainWave:draw()
   if constants.DEBUG_MODE then
      love.graphics.setColor(255, 0, 255)
      love.graphics.circle("line", self.position.x, self.position.y, self.radius)
      love.graphics.setColor(255, 255, 255)
   end
end

return ChainWave
