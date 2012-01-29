-- Require any needed modules.
local Gamestate = require "hump.gamestate"
--local play = require "states.play"

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
   print("Got to gameover state!")
   play = Gamestate.new()
   Gamestate.switch(play);
end

-- Called when this state is drawn.
function gameover:draw()
   love.graphics.print("Game over!", 100, 100)
end

-- Used for idiomatic module loading.
return gameover
