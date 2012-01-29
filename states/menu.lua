-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector = require "hump.vector"
local constants = require "constants"
local play = require "states.play"

-- Create the game state.
local menu = Gamestate.new()

local spring_k = 0.4
local friction = 0.9
local background = {}
local menuPlane = {}
local logo = {}
local oro = {}

-- Initialize the state. Called once when it's first created.
function menu:init()
   background = {
      image = love.graphics.newImage("Assets/menuBackground.png"),
   }

   menuPlane = {
      image = love.graphics.newImage("Assets/menuPlane.png"),
      position = Vector(-1000, 0),
      velocity = Vector(0, 0)
   }

   logo = {
      image = love.graphics.newImage("Assets/Logo.png"),
      position = Vector(1025, 100),
      velocity = Vector(0, 0)
   }

   oro = {
      image = love.graphics.newImage("Assets/ShadowOroborous.png"),
      position = Vector(constants.CENTER.x, 1500),
      rotation = 0,
      velocity = Vector(0, 0)
   }
end

-- Called when this state is entered with the previous state.
function menu:enter(previous)
   -- TODO: reset

end

-- Called when this state is updated.
function menu:update(dt)
   oro.rotation = (oro.rotation + .1*dt) % 360

   local function spring(object, target)
      local a = (target - object.position) * spring_k
      object.velocity = (object.velocity + a) * friction
      object.position = object.position + object.velocity * dt
   end

   spring(menuPlane, Vector(0, 0))
   spring(logo, Vector(constants.CENTER.x - 300, 100))
   spring(oro, constants.CENTER:clone())
end

-- Called when this state is drawn.
function menu:draw()
   love.graphics.draw(background.image, 0,0)

   love.graphics.draw(oro.image,
      oro.position.x , oro.position.y,
      oro.rotation,
      1,1,
      512, 512)

   love.graphics.draw(menuPlane.image, menuPlane.position.x, menuPlane.position.y)

--   love.graphics.draw(logo.image, constants.CENTER.x-300, 100)
   love.graphics.draw(logo.image, logo.position.x, logo.position.y)
end

function menu:keypressed()
   Gamestate.switch(play)
end

function menu:mousepressed()
   Gamestate.switch(play)
end


-- Used for idiomatic module loading.
return menu
