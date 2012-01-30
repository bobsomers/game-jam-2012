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

local wait_time = 0
local fadeOut = 0

-- Initialize the state. Called once when it's first created.
function gameover:init()
   self:reset()
end

function gameover:reset()
   background = {}
   goLogo = {}
   menuPlane = {}
   hud = {}
   planes = {}
   snake = {}
   score = 0
   snakeHealth = 0
   
   fadeOut = 0
   wait_time = 0

   background = love.graphics.newImage("images/background.png")
   goLogo = love.graphics.newImage("images/game_over.png")
   menuPlane = love.graphics.newImage("images/menu_plane.png")
end

-- Called when this state is entered with the previous state.
function gameover:enter(previouis, hudd, oldplanes, Rscore)
   self:reset()

   hud = hudd
   planes = oldplanes   
   score = Rscore
end

-- Called when this state is updated.
function gameover:update(dt)
   wait_time = wait_time + dt

   if fadeOut < 255 then
      -- The number after dt determines how fast the fadeout happens
	fadeOut = fadeOut + dt*45
   end

   if fadeOut > 255 then
      fadeOut = 255
   end
end

-- Called when this state is drawn.
function gameover:draw()

   love.graphics.draw(background, 0,0)
   --love.graphics.draw(menuPlane,0,0)

   for i, plane in ipairs(planes) do
      plane:draw()
   end
  
   --fadeout
   love.graphics.setColor(0,0,0,fadeOut)
   love.graphics.rectangle("fill", 0,0, constants.SCREEN.x, constants.SCREEN.y )
   love.graphics.setColor(255,255,255,255)

   love.graphics.draw(goLogo, constants.CENTER.x-300, 100)

   if fadeOut > 100  then
	   love.graphics.setColor(255,255,255, fadeOut-100)
	   love.graphics.print("By", constants.CENTER.x-20, constants.CENTER.y + 20, 0, .4, .4 )
	   love.graphics.print("Taylor Arnicar", constants.CENTER.x-50, constants.CENTER.y + 50, 0, .4, .4 )
	   love.graphics.print("Katherine Blizard", constants.CENTER.x-10, constants.CENTER.y + 80, 0, .4, .4 )
	   love.graphics.print("Sterling Hirsh", constants.CENTER.x-40, constants.CENTER.y + 110, 0, .4 ,.4 )
	   love.graphics.print("Marc Zych", constants.CENTER.x+20, constants.CENTER.y + 140 , 0, .4 ,.4 )
	   love.graphics.print("Bob Somers", constants.CENTER.x+50, constants.CENTER.y + 170 , 0, .4 ,.4 )
	   love.graphics.print("Shirley Song", constants.CENTER.x+30, constants.CENTER.y + 200 , 0, .4 ,.4 )
   end
   love.graphics.setColor(255,255,255,255)
   hud:draw(0, score)
end

function gameover:keypressed()
   if wait_time > 2 then
      sound.playMenu()
      Gamestate.switch(menu)
   end
end

function gameover:mousepressed()
   if wait_time > 2 then
      sound.playMenu()
      Gamestate.switch(menu)
   end
end

-- Used for idiomatic module loading.
return gameover
