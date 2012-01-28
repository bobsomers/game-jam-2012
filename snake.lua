local Class = require "hump.class"
local Vector = require "hump.vector"

Snake = Class(function(self)
    self.position = Vector(1024 / 2, 768 / 2)
    self.SPIN_RATE = 0.3
    self.rotation = 0
end)

function Snake:init()
    self.image = love.graphics.newImage("tmpart/ring.png")
end

function Snake:update(dt)

end

function Snake:draw()
    love.graphics.draw(self.image,
        self.position.x, self.position.y,
        self.rotation,
        1, 1,
        100, 100)
end

function Snake:rotateLeft()
    self.rotation = self.rotation - self.SPIN_RATE
end

function Snake:rotateRight()
    self.rotation = self.rotation + self.SPIN_RATE
end
