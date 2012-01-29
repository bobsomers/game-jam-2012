local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

local Awesome = Class(function(self, font, number, position)
   self.font = font
   self.position = position
   self.number = number
   self.scale = 1
   self.time = 0
   self.active = true
end)

function Awesome:update(dt)
   self.time = self.time + dt

   self.scale = self.time
   self.opacity = 1 - self.time

   if self.time > 1 then
      self.active = false
   end
end

function Awesome:draw()
   local scale = self.scale * self.number * 0.5
   if self.time > 0.3 then
      love.graphics.setFont(self.font)
      love.graphics.setColor(255, 255, 255, self.opacity * 255)
      love.graphics.print("x" .. self.number,
         self.position.x, self.position.y,
         0,
         scale, scale)
      love.graphics.setColor(255, 255, 255, 255)
   end
end

return Awesome
