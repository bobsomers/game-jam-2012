-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local constants = require "constants"

local background = love.graphics.newImage("Assets/menuBackground.png")
local goLogo = love.graphics.newImage("Assets/GameOver.png")
local menuPlane = love.graphics.newImage("Assets/menuPlane.png")

-- Create the game state.
local gameover = Gamestate.new()

-- Initialize the state. Called once when it's first created.
function gameover:init()

end

-- Called when this state is entered with the previous state.
function gameover:enter(previous)
end

-- Called when this state is updated.
function gameover:update(dt)
   --print("Got to gameover state!")
   
end

-- Called when this state is drawn.
function gameover:draw()
   love.graphics.draw(background, 0,0)
   love.graphics.draw(menuPlane,0,0)
   love.graphics.draw(goLogo, constants.CENTER.x-300, 100)

   --love.graphics.print("Game over!", 100, 100)

end

function gameover:keypressed()
   --play = Gamestate.new()  
--   Gamestate.switch(menu)
end

function gameover:mousepressed()
--   Gamestate.switch(menu)
end
-- Used for idiomatic module loading.
return gameover
