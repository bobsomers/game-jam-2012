-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local constants = require "constants"

-- Create the game state.
local gameover = Gamestate.new()

local background = {}
local goLogo = {}
local menuPlane = {}

-- Initialize the state. Called once when it's first created.
function gameover:init()
   background = love.graphics.newImage("images/menu_background.png")
   goLogo = love.graphics.newImage("images/game_over.png")
   menuPlane = love.graphics.newImage("images/menu_plane.png")
end

-- Called when this state is entered with the previous state.
function gameover:enter(previous)
end

-- Called when this state is updated.
function gameover:update(dt)
   
end

-- Called when this state is drawn.
function gameover:draw()
   love.graphics.draw(background, 0,0)
   love.graphics.draw(menuPlane,0,0)
   love.graphics.draw(goLogo, constants.CENTER.x-300, 100)
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
