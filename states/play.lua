-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"
local Snake = require "entities.snake"
local Plane = require "entities.plane"
local Player = require "entities.player"
local Bullet = require "entities.bullet"
local Background = require "fx.background"
local Explosion = require "fx.explosion"
local Poof = require "fx.poof"
local constants = require "constants"
local gameover = require "states.gameover"
local Hud = require "entities.hud"

-- Start off with 0 planes in the game.
numPlanes = 0
-- Start off wanting 1 plane in the game.
numPlanesToHave = 1
-- Seed the random number generator based on the system time
math.randomseed(os.time())

-- Create the game state.
local play = Gamestate.new()

-- Declare these variables here so that they're local to the file, not to the
-- function in which they were first mentioned.
local snake = {}
local player = {}
local planes = {}
local bullets = {}
local booms = {}
local poofs = {}
local background = {}
local hud = {}

-- Initialize the state. Called once when it's first created.
function play:init()
   -- Load the background.
   background = Background()

   -- Create the snake.
   snake = Snake(love.graphics.newImage("Assets/Oroboroussmall.png"))

   -- Create the player.
   player = Player(love.graphics.newImage("tmpart/jamsackson.png"))

   -- Prep the bullet image.
   bullets.image = love.graphics.newImage("tmpart/bullet.png")
   
   -- Prep the plane image and trail image. 
   -- TODO: Marc, conditionalize the following line:
   plane_image = love.graphics.newImage("tmpart/plane.jpg")
   planes.trail = love.graphics.newImage("fx/particle.png")

   -- Prep the effects.
   booms.image = love.graphics.newImage("fx/particle.png")
   poofs.image = love.graphics.newImage("fx/particle.png")

   hud = Hud()
end

-- Called when this state is entered with the previous state.
function play:enter(previous)
   print("Just entered play state")
end

-- Called when this state is updated.
function play:update(dt)
   local center = constants.SCREEN / 2

   background:update(dt)

   -- For each plane that's missing, let's give a 5% chance to craete it.
   for i = numPlanes, numPlanesToHave do
      if (math.random(1,100) <= constants.SPAWN_ENEMY_CHANCE) then 
         -- Spawn a plane with the plane image, make sure it's off the screen,
         -- give it a random theta (radial location), and random
         -- r and theta speeds.
         table.insert(planes, Plane(plane_image, planes.trail, constants.SCREEN.x / 1.8, math.random(1,6), math.random(-20, -10), math.random(-100, 100) / 120))
      end
   end

   if (math.random(1,100) <= constants.INCREASE_MAX_ENEMY_COUNT_CHANCE) then
      numPlanesToHave = numPlanesToHave + 1
   end

   -- Update all objects that need to be updated
   snake:update(dt)
   player:update(dt)
   for i, plane in ipairs(planes) do
      plane:update(dt)
   end
   for i, bullet in ipairs(bullets) do
      bullet:update(dt)
      local distance2 = (bullet.position - center):len2()
      if distance2 > center:len2() then
         table.remove(bullets, i)
      end
   end

   -- Collision detection between bullets and planes!
   for i, bullet in ipairs(bullets) do
      for j, plane in ipairs(planes) do
         local plane_position = plane.position + center
         local distance = (plane_position - bullet.position):len()
         if distance < constants.BULLET_RADIUS + constants.PLANE_RADIUS then
            -- If the plane is destroyed by this bullet, then remove it and the bullet
            if (plane:getShot(bullet)) then
               table.insert(booms, Explosion(booms.image, plane_position))
               table.remove(planes, j)
               table.remove(bullets, i)
            end
         end
      end
   end

   -- Collision detection between planes and snake!
   for i, plane in ipairs(planes) do
      local plane_position = plane.position + center
      local distance = (plane_position - snake.position):len()
      if distance < constants.BULLET_RADIUS + constants.SNAKE_RADIUS then
         plane:crashIntoSnake()
         table.remove(planes,i)
      end
   end

   if (constants.SNAKE_CURRENT_HEALTH <= 0) then
      Gamestate.switch(gameover)
   end

   -- Update the effects.
   for i, boom in ipairs(booms) do
      if boom.active then
         boom:update(dt)
      else
         table.remove(booms, i)
      end
   end
   for i, poof in ipairs(poofs) do
      if poof.active then
         poof:update(dt)
      else
         table.remove(poofs, i)
      end
   end
end

-- Called when this state is drawn.
function play:draw()
   background:draw()
   snake:draw()
   player:draw()
   for i, plane in ipairs(planes) do
      plane:draw()
   end
   for i, bullet in ipairs(bullets) do
      bullet:draw()
   end
   for i, boom in ipairs(booms) do
      boom:draw()
   end
   for i, poof in ipairs(poofs) do
      poof:draw()
   end

   hud.draw()   
end

function play:mousepressed(x, y, button)
   if button == "wd" then
      snake:spinCW()
   end
   if button == "wu" then
      snake:spinCCW()
   end

   if button == "l" then
      local direction = player.position:normalized()
      local location = (constants.SCREEN / 2) + player.position +
         (direction * player.SIZE.y)
      table.insert(bullets, Bullet(bullets.image, location, direction,
         snake:getCurrentColor(player.theta)))
   end
end

-- Used for idiomatic module loading.
return play
