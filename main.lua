Gamestate = require "hump.gamestate"

-- Load game states.
love.filesystem.load("menu_state.lua")()
love.filesystem.load("play_state.lua")()
love.filesystem.load("end_state.lua")()

function love.load()
   -- Register the game state dispatcher and switch into the initial state.
   Gamestate.registerEvents()
   Gamestate.switch(play_state)
end
