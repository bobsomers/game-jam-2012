local Class = require "hump.class"
local Vector = require "hump.vector"

Snake = Class(function(self)
    self.position = Vector(1024 / 2, 768 / 2)
    self.SPIN_RATE = 1
end)

function Snake:init()
    self.image = love.graphics.newImage("tmpart/ring.png")
    self.rotation = 0;
end

function Snake:update(dt)
   if love.mouse.isDown("l") then
      self.rotation = self.rotation + self.SPIN_RATE * dt
   elseif love.mouse.isDown("r") then
      self.rotation = self.rotation - self.SPIN_RATE * dt
   end
end

function Snake:draw()
    love.graphics.draw(self.image,
        self.position.x, self.position.y,
        self.rotation,
        1, 1,
        100, 100)
end
