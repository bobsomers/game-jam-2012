-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local constants = require "constants"

-- Define the class (and constructor).
local Background = Class(function(self)
   self.plate = love.graphics.newImage("Assets/GGJ_Background.png")
   self.clouds = {
      {
         image = love.graphics.newImage("Assets/GGJ_Background_cloud1.png"),
         rotation = 0,
         speed = 0.03
      },
      {
         image = love.graphics.newImage("Assets/GGJ_Background_cloud2.png"),
         rotation = 0,
         speed = 0.05
      },
      {
         image = love.graphics.newImage("Assets/GGJ_Background_cloud3.png"),
         rotation = 0,
         speed = 0.07
      }
   }
   self.stars = {
      love.graphics.newImage("Assets/GGJ_Background_star1.png"),
      love.graphics.newImage("Assets/GGJ_Background_star2.png")
   }
   self.time = 0
end)

function Background:update(dt)
   self.time = self.time + dt
   for i, cloud in ipairs(self.clouds) do
      cloud.rotation = cloud.rotation + cloud.speed * dt
   end
end

function Background:draw()
   love.graphics.draw(self.plate, 0, 0)
   for i, star in ipairs(self.stars) do
      love.graphics.draw(star, 0, 0)
   end
   for i, cloud in ipairs(self.clouds) do
      love.graphics.draw(cloud.image,
         constants.CENTER.x, constants.CENTER.y,
         cloud.rotation,
         1, 1,
         cloud.image:getWidth() / 2, cloud.image:getHeight() / 2)
   end
end

-- Used for idiomatic module loading.
return Background
