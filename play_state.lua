Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"

love.filesystem.load("snake.lua")()
love.filesystem.load("bullet.lua")()

play_state = Gamestate.new()
local testPic = love.graphics.newImage("tmpart/plane.jpg");

local snake = Snake()
local bullets = {}    
function play_state:init()
    love.graphics.setBackgroundColor(255, 255, 255)

    snake:init()
  
end

function play_state:enter(previous)

end

function play_state:update(dt)
    snake:update(dt)

    local i = 1
    for i=1, #bullets, i + 1 do
	bullets[i]:update(dt)
    end 

end

function play_state:draw()
    love.graphics.print("Play state!", 100, 100)
    love.graphics.draw(testPic, 50, 50, 1, 1, 1, 0, 0);

    snake:draw()

    local i = 1
    for i=1, #bullets, i + 1 do
	bullets[i]:draw()
    end
end

function play_state:mousereleased(x, y, button)
    if button == "wd" then
        snake:rotateLeft()
    elseif button == "wu" then
        snake:rotateRight()
    elseif button == "l" then
	local bullet = Bullet();
	bullet:fire(Vector(512, 512), Vector(0,1))
	table.insert(bullets, bullet)
    end
end
