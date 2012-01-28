local Class = require "hump.class"
local Vector = require "hump.vector"

Snake = Class(function(self)
    self.position = Vector(1024 / 2, 768 / 2)
    self.SPIN_RATE = 1.5
    self.rotation = 0
end)

function Snake:init()
    self.image = love.graphics.newImage("tmpart/ring.png")
end

function Snake:update(dt)
   if love.keyboard.isDown("o") then
      self:spinCCW(dt)
   end
   if love.keyboard.isDown("p") then
      self:spinCW(dt)
   end
end

function Snake:draw()
    love.graphics.draw(self.image,
        self.position.x, self.position.y,
        self.rotation,
        1, 1,
        100, 100)
end

function Snake:spinCW(dt)
   self.rotation = self.rotation + self.SPIN_RATE * dt
end

function Snake:spinCCW(dt)
   self.rotation = self.rotation - self.SPIN_RATE * dt
end
