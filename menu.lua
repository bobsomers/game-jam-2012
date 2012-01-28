-- Require any needed modules.
local Gamestate = require "hump.gamestate"

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

end

-- Called when this state is drawn.
function menu:draw()
   love.graphics.print("Menu state!", 100, 100)
end

-- Used for idiomatic module loading.
return menu
