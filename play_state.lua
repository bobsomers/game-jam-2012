Gamestate = require "hump.gamestate"

love.filesystem.load("snake.lua")()

play_state = Gamestate.new()
local testPic = love.graphics.newImage("tmpart/plane.jpg");

local snake = Snake()
    
function play_state:init()
    love.graphics.setBackgroundColor(255, 255, 255)

    snake:init()
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
