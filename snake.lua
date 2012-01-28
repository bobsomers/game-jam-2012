local Class = require "hump.class"
local Vector = require "hump.vector"

Snake = Class(function(self)
    self.position = Vector(1024 / 2, 768 / 2)
end)

function Snake:init()
    self.image = love.graphics.newImage("tmpart/ring.png")
end

function Snake:update(dt)

end

function Snake:draw()
    love.graphics.draw(self.image,
        self.position.x, self.position.y,
        0,
        1, 1,
        100, 100)
end
