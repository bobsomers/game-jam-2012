Gamestate = require "hump.gamestate"

menu_state = Gamestate.new()

function menu_state:init()

end

function menu_state:enter(previous)

end

function menu_state:update(dt)

end

function menu_state:draw()
    love.graphics.print("Menu state!", 100, 100)
end
