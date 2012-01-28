Gamestate = require "hump.gamestate"

play_state = Gamestate.new()

function play_state:init()

end

function play_state:enter(previous)

end

function play_state:update(dt)

end

function play_state:draw()
    love.graphics.print("Play state!", 100, 100)
end
