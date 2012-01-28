-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"
require "plane" -- TODO

-- TODO
love.filesystem.load("snake.lua")()
love.filesystem.load("bullet.lua")()
love.filesystem.load("player.lua")()

-- Create the game state.
local play = Gamestate.new()

local testPic = love.graphics.newImage("tmpart/plane.jpg");

local snake = Snake()
local bullets = {}    
local player = Player()

-- Initialize the state. Called once when it's first created.
function play:init()
   love.graphics.setBackgroundColor(255, 255, 255)

   snake:init()
   player:init()
   Bullet:init()
   p = Plane ("red", testPic, 350, 0, -10, 1); 
   p2 = Plane ("red", testPic, 400, 0, -15, 1.3); 
   p3 = Plane ("red", testPic, 450, 0, -20, -1); 
end

-- Called when this state is entered with the previous state.
function play:enter(previous)

end

-- Called when this state is updated.
function play:update(dt)
   snake:update(dt)
   player:update(dt)
   p:update(dt)
   p2:update(dt)
   p3:update(dt)
    local i = 1
    for i,bb in ipairs(bullets) do
      --if bb.lifespan < 15 then
	bb:update(dt)
      --else
	--table.remove(bullets,i)
      --end
    end 
   
end

-- Called when this state is drawn.
function play:draw()
   snake:draw()
   player:draw()
   p:draw();
   p2:draw();
   p3:draw();
   local i = 1
   for i=1, #bullets, i + 1 do
	   bullets[i]:draw()
   end
end

-- Called when the mouse is released in this state.
function play:mousereleased(x, y, button)
   if button == "l" then
	   local bullet = Bullet();
      bullet:fire(Vector(512, 512), Vector(0,200))
      table.insert(bullets, bullet)
   end
end

-- Used for idiomatic module loading.
return play
