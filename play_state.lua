love.filesystem.load("Plane.lua")()
Gamestate = require "hump.gamestate"

love.filesystem.load("snake.lua")()

play_state = Gamestate.new()
local testPic = love.graphics.newImage("tmpart/plane.jpg");

local snake = Snake()
    
function play_state:init()
    love.graphics.setBackgroundColor(255, 255, 255)

    snake:init()
   p = Plane ("red", testPic, 400, 0, -10, 1); 
   p2 = Plane ("red", testPic, 400, 0, -10, 1); 
   p3 = Plane ("red", testPic, 400, 0, -10, 1); 
end

function play_state:enter(previous)

end

function play_state:update(dt)
    snake:update(dt)
end

function play_state:draw()
    love.graphics.print("Play state!", 100, 100)
    love.graphics.draw(testPic, 50, 50, 1, 1, 1, 0, 0);

    snake:draw()
end

function play_state:mousereleased(x, y, button)
    if button == "wd" then
        snake:rotateLeft()
    elseif button == "wu" then
        snake:rotateRight()
    end

   p:update(dt)
   p2:update(dt)
   p3:update(dt)
end

function play_state:draw()
    love.graphics.print("Play state!", 100, 100);
    p:draw();
    p2:draw();
    p3:draw();
    --love.graphics.draw(testPic, 50, 50, 1, 1, 1, 0, 0);
end
