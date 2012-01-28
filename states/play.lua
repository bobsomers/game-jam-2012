-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"
local Snake = require "entities.snake"
local Plane = require "entities.plane"
local Player = require "entities.player"

-- TODO
--love.filesystem.load("bullet.lua")()

-- Create the game state.
local play = Gamestate.new()

-- Declare these variables here so that they're local to the file, not to the
-- function in which they were first mentioned.
local snake = {}
local player = {}
local planes = {}
--local bullets = {}

-- Initialize the state. Called once when it's first created.
function play:init()
   -- White is a nice background color.
   love.graphics.setBackgroundColor(255, 255, 255)

   -- Create the snake.
   snake = Snake(love.graphics.newImage("tmpart/ring.png"))

   -- Create the player.
   player = Player(love.graphics.newImage("tmpart/jamsackson.png"))

   -- Create some planes.
   local plane_image = love.graphics.newImage("tmpart/plane.jpg")
   table.insert(planes, Plane(plane_image, "red", 350, 0, -10, 1))
   table.insert(planes, Plane(plane_image, "red", 400, 0, -15, 1))
   table.insert(planes, Plane(plane_image, "red", 450, 0, -20, -1))
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

--   local i = 1
--   for i,bb in ipairs(bullets) do
--      --if bb.lifespan < 15 then
--	bb:update(dt)
--      --else
--	--table.remove(bullets,i)
--      --end
--    end 
   
end

-- Called when this state is drawn.
function play:draw()
   snake:draw()
   player:draw()
   for i, plane in ipairs(planes) do
      plane:draw(dt)
   end

--   local i = 1
--   for i=1, #bullets, i + 1 do
--	   bullets[i]:draw()
--   end
end

-- Called when the mouse is released in this state.
function play:mousereleased(x, y, button)
--   if button == "l" then
--	   local bullet = Bullet();
--      bullet:fire(Vector(512, 512), Vector(0,200))
--      table.insert(bullets, bullet)
--   end
end

-- Used for idiomatic module loading.
return play
