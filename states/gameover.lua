-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local constants = require "constants"
local Vector =  require "hump.vector"
local Camera = require "hump.camera"
local Snake = require "entities.snake"
local Plane = require "entities.plane"
local Player = require "entities.player"
local Bullet = require "entities.bullet"
local Background = require "fx.background"
local Explosion = require "fx.explosion"
local Poof = require "fx.poof"
local FireJet = require "fx.fire_jet"
local Earthquake = require "fx.earthquake"
local constants = require "constants"
local Hud = require "entities.hud"
local sound = require "sound"
local ChainWave = require "entities.chain_wave"



-- Create the game state.
local gameover = Gamestate.new()

local background = {}
local goLogo = {}
local menuPlane = {}
local hud = {}
local planes = {}
local snake = {}
local score = 0
local snakeHealth = 0

-- Initialize the state. Called once when it's first created.
function gameover:init()
   background = love.graphics.newImage("images/background.png")
   goLogo = love.graphics.newImage("images/game_over.png")
   menuPlane = love.graphics.newImage("images/menu_plane.png")
end

-- Called when this state is entered with the previous state.
function gameover:enter(previouis, hudd, oldplanes, Rscore)
   --background = bg 
   hud = hudd
   planes = oldplanes   
   score = Rscore
end

-- Called when this state is updated.
function gameover:update(dt)
   
end

-- Called when this state is drawn.
function gameover:draw()

   love.graphics.draw(background, 0,0)
   --love.graphics.draw(menuPlane,0,0)

   for i, plane in ipairs(planes) do
      plane:draw()
   end

   love.graphics.draw(goLogo, constants.CENTER.x-300, 100)

   hud:draw(0, score)
end

function gameover:keypressed()
   --play = Gamestate.new()  
   Gamestate.switch(menu)
end

function gameover:mousepressed()
   Gamestate.switch(menu)
end

-- Used for idiomatic module loading.
return gameover
