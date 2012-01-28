local Class = require "hump.class"
local Vector = require "hump.vector"

love.filesystem.load("utils.lua")()

Player = Class(function(self)
   self.theta = 3 * math.pi / 2
   self.RADIUS = 100
   self.SIZE = Vector(20, 40)
   self.SPIN_RATE = 1.5
   self.position = polarToCartesian(self.theta, self.RADIUS)
end)

function Player:init()
   self.image = love.graphics.newImage("tmpart/jamsackson.png")
end

function Player:update(dt)
   if love.keyboard.isDown("q") then
      self:spinCCW(dt)
   end
   if love.keyboard.isDown("w") then
      self:spinCW(dt)
   end
   self.position = polarToCartesian(self.RADIUS, self.theta)
   print(self.RADIUS .. " " .. self.theta .. " " .. tostring(self.position))
end

function Player:draw()
   love.graphics.draw(self.image,
      (1024 / 2) + self.position.x, (768 / 2) + self.position.y,
      self.theta + math.pi / 2,
      1, 1,
      self.SIZE.x / 2, self.SIZE.y)
end

function Player:spinCW(dt)
   self.theta = self.theta + self.SPIN_RATE * dt
end

function Player:spinCCW(dt)
   self.theta = self.theta - self.SPIN_RATE * dt
end
