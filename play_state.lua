Gamestate = require "hump.gamestate"

play_state = Gamestate.new()
local testPic = love.graphics.newImage("tmpart/plane.jpg");
    
function play_state:init()
end

function play_state:enter(previous)

end

function play_state:update(dt)

end

function play_state:draw()
    love.graphics.print("Play state!", 100, 100)
    love.graphics.draw(testPic, 50, 50, 1, 1, 1, 0, 0);
end
