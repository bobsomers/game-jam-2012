-- Require any needed modules.
local Gamestate = require "hump.gamestate"

-- Load game states.
local menu = require "menu"
local play = require "play"
local gameover = require "gameover"

function love.load()
   -- Register the game state dispatcher and switch into the initial state.
   Gamestate.registerEvents()
   Gamestate.switch(play)
end
