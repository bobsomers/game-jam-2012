local Class = require "hump.class"
local Vector = require "hump.vector"
local Constants = require "constants"

Bullet = Class(function(self)
    self.position = Vector(Constants.SCREEN.x / 2, Constants.SCREEN.y / 2)
    self.direction = Vector( 0, 1)
    --self.SPIN_RATE = 0.3
    self.rotation = 0
    self.color = "grey"
end)


function Bullet:init()
    self.image = love.graphics.newImage("tmpart/ring.png")
end

function Bullet:update(dt)	
    self.position.x = self.position.x + self.direction.x*dt
    self.position.y = self.position.y + self.direction.y*dt
end

function Bullet:draw()
    love.graphics.draw(self.image,
        self.position.x, self.position.y,
        self.rotation,
        .1, .1,
        100, 100)
end

function Bullet:fire(startLocation, startdirection)
	self.position = startLocation;
	self.direction = startdirection;
end
