-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"
local Snake = require "entities.snake"
local Plane = require "entities.plane"
local Player = require "entities.player"
local Bullet = require "entities.bullet"
local constants = require "constants"

-- TODO
--love.filesystem.load("bullet.lua")()

-- Create the game state.
local play = Gamestate.new()

-- Declare these variables here so that they're local to the file, not to the
-- function in which they were first mentioned.
local snake = {}
local player = {}
local planes = {}
local bullets = {}

-- Initialize the state. Called once when it's first created.
function play:init()
   -- White is a nice background color.
   love.graphics.setBackgroundColor(255, 255, 255)

   -- Create the snake.
   snake = Snake(love.graphics.newImage("tmpart/ring.png"))

   -- Create the player.
   player = Player(love.graphics.newImage("tmpart/jamsackson.png"))

   -- Create some planes.
   planes.image = love.graphics.newImage("tmpart/plane.jpg")
   table.insert(planes, Plane(planes.image, "red", 350, 0, -10, 1))
   table.insert(planes, Plane(planes.image, "red", 400, 0, -15, 1))
   table.insert(planes, Plane(planes.image, "red", 450, 0, -20, -1))

   -- Prep the bullet image.
   bullets.image = love.graphics.newImage("tmpart/bullet.png")
end

-- Called when this state is entered with the previous state.
function play:enter(previous)

end

-- Called when this state is updated.
function play:update(dt)
   snake:update(dt)
   player:update(dt)
   for i, plane in ipairs(planes) do
      plane:update(dt)
   end
   for i, bullet in ipairs(bullets) do
      bullet:update(dt)
      local center = constants.SCREEN / 2
      local distance2 = (bullet.position - center):len2()
      if distance2 > center:len2() then
         table.remove(bullets, i)
      end
   end
end

-- Called when this state is drawn.
function play:draw()
   snake:draw()
   player:draw()
   for i, plane in ipairs(planes) do
      plane:draw()
   end
   for i, bullet in ipairs(bullets) do
      bullet:draw()
   end
end

function play:keypressed(key)
   if key == " " then
      local direction = player.position:normalized()
      local location = (constants.SCREEN / 2) + player.position +
         (direction * player.SIZE.y)
      table.insert(bullets, Bullet(bullets.image, location, direction))
   end
end

-- Used for idiomatic module loading.
return play
