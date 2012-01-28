love.filesystem.load("plane.lua")()
Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"

love.filesystem.load("snake.lua")()
love.filesystem.load("bullet.lua")()
love.filesystem.load("player.lua")()

play_state = Gamestate.new()
local testPic = love.graphics.newImage("tmpart/plane.jpg");

local snake = Snake()
local bullets = {}    
local player = Player()

function play_state:init()
   love.graphics.setBackgroundColor(255, 255, 255)

   snake:init()
   player:init()
   p = Plane ("red", testPic, 350, 0, -10, 1); 
   p2 = Plane ("red", testPic, 400, 0, -15, 1.3); 
   p3 = Plane ("red", testPic, 450, 0, -20, -1); 
end

function play_state:enter(previous)

end

function play_state:update(dt)
   snake:update(dt)
   player:update(dt)
   p:update(dt)
   p2:update(dt)
   p3:update(dt)
   local i = 1
   for i=1, #bullets, i + 1 do
      bullets[i]:update(dt)
   end 
end

function play_state:draw()
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

function play_state:mousereleased(x, y, button)
   if button == "l" then
	   local bullet = Bullet();
      bullet:fire(Vector(512, 512), Vector(0,200))
      table.insert(bullets, bullet)
   end
end
