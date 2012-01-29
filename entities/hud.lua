
local Class = require "hump.class"
local constants = require "constants"

local Hud = Class(function()
end)

function Hud:load()
end

function Hud:update(dt)
end

function Hud:draw(snakehealth, score)
	love.graphics.rectangle("fill" , constants.SCREEN.x-100, 0, 100, constants.SCREEN.y)
end

-- idiomatic module loadinf
return Hud
