local constants = require "constants"

function love.conf(t)
   -- Game info.
   t.title = constants.TITLE
   t.author = constants.AUTHOR

   -- Graphic settings.
   t.screen.width = constants.SCREEN.x
   t.screen.height = constants.SCREEN.y

   -- Debugging for now.
   t.console = constants.DEBUG_MODE
end
