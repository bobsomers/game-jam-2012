-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector = require "hump.vector"
local constants = require "constants"
local sound = require "sound"

-- Create the game state.
local menu = Gamestate.new()

local font = {}
local spring_k = 0.4
local friction = 0.85
local background = {}
local menuPlane = {}
local logo = {}
local oro = {}
local instructions = {}

-- Initialize the state. Called once when it's first created.
function menu:init()
   self:reset()
end

function menu:reset()
   font = love.graphics.newFont("fonts/defused.ttf", 64)

   background = {
      image = love.graphics.newImage("images/menu_background.png"),
   }

   menuPlane = {
      image = love.graphics.newImage("images/menu_plane.png"),
      position = Vector(-1000, 0),
      velocity = Vector(0, 0)
   }

   logo = {
      image = love.graphics.newImage("images/title.png"),
      position = Vector(1025, 100),
      velocity = Vector(0, 0)
   }

   oro = {
      image = love.graphics.newImage("images/oroborous_shadow.png"),
      position = Vector(constants.CENTER.x, 1500),
      rotation = 0,
      velocity = Vector(0, 0)
   }

   instructions = {
      position = Vector(0, 800),
      velocity = Vector(0, 0)
   }
end

-- Called when this state is entered with the previous state.
function menu:enter(previous)
   self:reset()
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
   spring(instructions, Vector(0, constants.SCREEN.y - 150))
end

-- Called when this state is drawn.
function menu:draw()
   love.graphics.setFont(font)

   love.graphics.draw(background.image, 0,0)

   love.graphics.draw(oro.image,
      oro.position.x , oro.position.y,
      oro.rotation,
      1,1,
      512, 512)

   love.graphics.draw(menuPlane.image, menuPlane.position.x, menuPlane.position.y)

   love.graphics.draw(logo.image, logo.position.x, logo.position.y)

   love.graphics.print("Shoot: left click",
      instructions.position.x + 20, instructions.position.y, 0, .4,.4)
   love.graphics.print("Spin: scroll wheel or keyboard W & S ",
      instructions.position.x + 20, instructions.position.y + 50, 0, .4,.4)
   love.graphics.print("Walk: keyboard A & D",
      instructions.position.x + 20, instructions.position.y + 100, 0, .4,.4)
end

function menu:keypressed()
   sound.motherfuckin()
   Gamestate.switch(play)
end

function menu:mousepressed()
   sound.motherfuckin()
   Gamestate.switch(play)
end


-- Used for idiomatic module loading.
return menu
