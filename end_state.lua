Gamestate = require "hump.gamestate"

end_state = Gamestate.new()

function end_state:init()

end

function end_state:enter(previous)

end

function end_state:update(dt)

end

function end_state:draw()
    love.graphics.print("End state!", 100, 100)
end
