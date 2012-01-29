-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"
local Snake = require "entities.snake"
local Plane = require "entities.plane"
local Player = require "entities.player"
local Bullet = require "entities.bullet"
local constants = require "constants"

-- Start off with 0 planes in the game.
numPlanes = 0
-- Start off wanting 1 plane in the game.
numPlanesToHave = 1
-- Load the image for the plane once. 
plane_image = love.graphics.newImage("tmpart/plane.jpg")
-- Seed the random number generator
math.randomseed(1234)

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

   -- Prep the bullet image.
   bullets.image = love.graphics.newImage("tmpart/bullet.png")
end

-- Called when this state is entered with the previous state.
function play:enter(previous)

end

-- Called when this state is updated.
function play:update(dt)
   local center = constants.SCREEN / 2

   -- For each plane that's missing, let's give a 5% chance to craete it.
   for i = numPlanes, numPlanesToHave do
      if (math.random(1,100) <= 1) then 
         table.insert(planes, Plane(plane_image, "red", 350, 0, -10, 1))
      end
   end

   if (math.random(1,100) == 1) then
      numPlanesToHave = numPlanesToHave + 1
   end

   -- Update all objects that need to be updated
   snake:update(dt)
   player:update(dt)
   for i, plane in ipairs(planes) do
      plane:update(dt)
   end
   for i, bullet in ipairs(bullets) do
      bullet:update(dt)
      local distance2 = (bullet.position - center):len2()
      if distance2 > center:len2() then
         table.remove(bullets, i)
      end
   end

   -- Collision detection!
   for i, bullet in ipairs(bullets) do
      for j, plane in ipairs(planes) do
         local plane_position = plane.position + center
         local distance = (plane_position - bullet.position):len()
         if distance < constants.BULLET_RADIUS + constants.PLANE_RADIUS then
            plane:destroy()
            table.remove(planes, j)
            table.remove(bullets, i)
         end
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
