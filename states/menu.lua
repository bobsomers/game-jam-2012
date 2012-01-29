-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local constants = require "constants"

local background = love.graphics.newImage("Assets/menuBackground.png")
local menuPlane = love.graphics.newImage("Assets/menuPlane.png")
local logo = love.graphics.newImage("Assets/Logo.png")
local oro = love.graphics.newImage("Assets/ShadowOroborous.png")

local rotation = 0

-- Create the game state.
local menu = Gamestate.new()

-- Initialize the state. Called once when it's first created.
function menu:init()

end

-- Called when this state is entered with the previous state.
function menu:enter(previous)

end

-- Called when this state is updated.
function menu:update(dt)
   rotation = (rotation + .1*dt) % 360

end

-- Called when this state is drawn.
function menu:draw()
   --love.graphics.print("Menu state!", 100, 100)
   love.graphics.draw(background, 0,0)
   love.graphics.draw(oro, constants.CENTER.x ,constants.CENTER.y, rotation, 1,1, 512, 512 )
   love.graphics.draw(menuPlane,0,0)
   love.graphics.draw(logo, constants.CENTER.x-300, 100)
end

function menu:keypressed()
   --play = Gamestate.new()  
   Gamestate.switch(play)
end

function menu:mousepressed()
   Gamestate.switch(play)
end


-- Used for idiomatic module loading.
return menu
