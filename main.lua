-- Require any needed modules.
local Gamestate = require "hump.gamestate"

-- Load game states.
intro = require "states.intro"
menu = require "states.menu"
play = require "states.play"
gameover = require "states.gameover"
local Sound = require "sound"

function love.load()
   -- Register the game state dispatcher and switch into the initial state.
   Gamestate.registerEvents()
   Gamestate.switch(intro)
   -- Load all sounds to be used in the game
   Sound.init()
end


