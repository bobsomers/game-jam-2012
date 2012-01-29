-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector = require "hump.vector"
local constants = require "constants"

-- Create the game state.
local intro = Gamestate.new()

local time = 0
local font = {}
local sam_jackson = {}
local on_plane = {}
local fight_snakes = {}
local you_are = {}
local jam_sackson = {}
local on_snake = {}
local fight_planes = {}
local background = {}

-- Initialize the state. Called once when it's first created.
function intro:init()
   time = 0
   font = love.graphics.newFont("Assets/Defused.ttf", 64)

   sam_jackson = {
      text = "Samuel L. Jackson",
      opacity = 0,
      position = Vector(70, 275)
   }
   on_plane = {
      text = "was on a plane",
      opacity = 0,
      position = Vector(130, 350)
   }
   fight_snakes = {
      text = "fighting snakes",
      opacity = 0,
      position = Vector(140, 425)
   }

   you_are = {
      text = "You are",
      opacity = 0,
      position = Vector(330, 250)
   }
   jam_sackson = {
      text = "Jamuel L. Sackson",
      opacity = 0,
      position = Vector(80, 325)
   }
   on_snake = {
      text = "on a snake",
      opacity = 0,
      position = Vector(250, 400)
   }
   fight_planes = {
      text = "fighting planes",
      opacity = 0,
      position = Vector(150, 475)
   }

   background = {
      image = love.graphics.newImage("Assets/menuBackground.png"),
      opacity = 0
   }
end

-- Called when this state is entered with the previous state.
function intro:enter(previous)
   time = 0
end

-- Called when this state is updated.
function intro:update(dt)
   time = time + dt

   -- First fade in.
   if time > 1 and time < 3 then
      sam_jackson.opacity = (time - 1) * 0.5
   end
   if time > 2 and time < 4 then
      on_plane.opacity = (time - 2) * 0.5
   end
   if time > 3 and time < 5 then
      fight_snakes.opacity = (time - 3) * 0.5
   end

   -- First fade out.
   if time > 4 and time < 6 then
      sam_jackson.opacity = 1 - ((time - 4) * 0.5)
   end
   if time > 5 and time < 7 then
      on_plane.opacity = 1 - ((time - 5) * 0.5)
   end
   if time > 6 and time < 8 then
      fight_snakes.opacity = 1 - ((time - 6) * 0.5)
   end

   -- Second fade in.
   if time > 8 and time < 10 then
      you_are.opacity = (time - 8) * 0.5
   end
   if time > 9 and time < 11 then
      jam_sackson.opacity = (time - 9) * 0.5
   end
   if time > 10 and time < 12 then
      on_snake.opacity = (time - 10) * 0.5
   end
   if time > 11 and time < 13 then
      fight_planes.opacity = (time - 11) * 0.5
   end

   -- Second fade out.
   if time > 12 and time < 14 then
      you_are.opacity = 1 - ((time - 12) * 0.5)
   end
   if time > 13 and time < 15 then
      jam_sackson.opacity = 1 - ((time - 13) * 0.5)
   end
   if time > 14 and time < 16 then
      on_snake.opacity = 1 - ((time - 14) * 0.5)
   end
   if time > 15 and time < 17 then
      fight_planes.opacity = 1 - ((time - 15) * 0.5)
   end

   -- Fade in menu background.
   if time > 15 and time < 17 then
      background.opacity = (time - 15) * 0.5
   end

   if time > 17 then
      Gamestate.switch(menu)
   end
end

-- Called when this state is drawn.
function intro:draw()
   love.graphics.setBackgroundColor(0, 0, 0)

   love.graphics.setFont(font)

   love.graphics.setColor(255, 255, 255, background.opacity * 255)
   love.graphics.draw(background.image, 0, 0)

   love.graphics.setColor(255, 255, 255, sam_jackson.opacity * 255)
   love.graphics.print(sam_jackson.text,
      sam_jackson.position.x, sam_jackson.position.y)

   love.graphics.setColor(255, 255, 255, on_plane.opacity * 255)
   love.graphics.print(on_plane.text,
      on_plane.position.x, on_plane.position.y)

   love.graphics.setColor(255, 255, 255, fight_snakes.opacity * 255)
   love.graphics.print(fight_snakes.text,
      fight_snakes.position.x, fight_snakes.position.y)

   love.graphics.setColor(255, 255, 255, you_are.opacity * 255)
   love.graphics.print(you_are.text,
      you_are.position.x, you_are.position.y)

   love.graphics.setColor(255, 255, 255, jam_sackson.opacity * 255)
   love.graphics.print(jam_sackson.text,
      jam_sackson.position.x, jam_sackson.position.y)

   love.graphics.setColor(255, 255, 255, on_snake.opacity * 255)
   love.graphics.print(on_snake.text,
      on_snake.position.x, on_snake.position.y)

   love.graphics.setColor(255, 255, 255, fight_planes.opacity * 255)
   love.graphics.print(fight_planes.text,
      fight_planes.position.x, fight_planes.position.y)

   love.graphics.setColor(255, 255, 255, 255)
end

function intro:keypressed()
   Gamestate.switch(menu)
end

function intro:mousepressed()
   Gamestate.switch(menu)
end


-- Used for idiomatic module loading.
return intro
