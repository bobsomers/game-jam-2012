-- Require any needed modules.
local Gamestate = require "hump.gamestate"

-- Load game states.
local menu = require "states.menu"
local play = require "states.play"
local gameover = require "states.gameover"
local Sound = require "sound"

function love.load()
   -- Register the game state dispatcher and switch into the initial state.
   Gamestate.registerEvents()
   Gamestate.switch(play)
   -- Load all sounds to be used in the game
   Sound.init()
end
