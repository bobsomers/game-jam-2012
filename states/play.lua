-- Require any needed modules.
local Gamestate = require "hump.gamestate"
local Vector =  require "hump.vector"
local Camera = require "hump.camera"
local Snake = require "entities.snake"
local Plane = require "entities.plane"
local Player = require "entities.player"
local Bullet = require "entities.bullet"
local Background = require "fx.background"
local Explosion = require "fx.explosion"
local Poof = require "fx.poof"
local FireJet = require "fx.fire_jet"
local Earthquake = require "fx.earthquake"
local constants = require "constants"
local Hud = require "entities.hud"

-- The player's score
score = 0
-- The snake should start with its max health
snakeHealth = constants.SNAKE_MAX_HEALTH
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
local firejets = {}
local background = {}
local hud = {}
local planeImages = {}
local playerImages = {}
local camera = {}
local earthquake = {}

-- Initialize the state. Called once when it's first created.
function play:init()
   -- Camera is looking at the center of the window.
   camera = Camera(constants.CENTER:clone(), 1, 0)
   earthquake = Earthquake(camera)

   -- Load the background.
   background = Background(camera)

   -- Create the snake.
   snake = Snake(love.graphics.newImage("Assets/Oroboroussmall.png"))

   -- Create the player.
   playerImages = {
      run = {
         love.graphics.newImage("images/jamuel_run_0.png"),
         love.graphics.newImage("images/jamuel_run_1.png")
      },
      stand = {
         love.graphics.newImage("images/jamuel_stand_0.png"),
         love.graphics.newImage("images/jamuel_stand_1.png")
      }
   }
   player = Player(playerImages)

   -- Prep the bullet frames.
   bullets.images = {
      love.graphics.newImage("images/bullet_0.png"),
      love.graphics.newImage("images/bullet_1.png"),
      love.graphics.newImage("images/bullet_2.png"),
      love.graphics.newImage("images/bullet_3.png"),
      love.graphics.newImage("images/bullet_4.png"),
      love.graphics.newImage("images/bullet_5.png"),
      love.graphics.newImage("images/bullet_6.png")
   }
   
   -- Prep the plane images and trail image. 
   planeImages["yellow"] = love.graphics.newImage("images/yellow_plane.png")
   planeImages["blue"] = love.graphics.newImage("images/blue_plane.png")
   planeImages["red"] = {
      love.graphics.newImage("images/red_plane_0.png"),
      love.graphics.newImage("images/red_plane_1.png")}
   planeImages["green"] = love.graphics.newImage("images/green_plane.png")

   planes.trail = love.graphics.newImage("fx/particle.png")

   -- Prep the effects.
   booms.image = love.graphics.newImage("fx/particle.png")
   poofs.image = love.graphics.newImage("fx/particle.png")
   firejets.image = love.graphics.newImage("fx/particle.png")

   hud = Hud()
end

-- Called when this state is entered with the previous state.
function play:enter(previous)
   --print("Just entered play state")
   snakeHealth = constants.SNAKE_MAX_HEALTH
   score = 0
   --planes = {}  --resetting planes breaks the game for some reason
   --bullets = {}
end

-- Called when this state is updated.
function play:update(dt)
   local center = constants.SCREEN / 2

   earthquake:update(dt)
   background:update(dt)

   -- For each plane that's missing, let's give a 5% chance to create it.
   for i = numPlanes, numPlanesToHave do
      if (math.random(1,100) <= constants.SPAWN_ENEMY_CHANCE) then 
         -- Spawn a plane with a random color (and appropriate image),
         -- make sure it's off the screen, give it a random theta (radial location),
         -- and random r and theta speeds.
         local color = constants.ENEMY_COLORS[math.random(1, #constants.ENEMY_COLORS)]
         -- Generate the thetaSpeed
         local thetaSpeed = math.random(10, 90) / 120 
         if (math.random(1,2) == 1) then
            thetaSpeed = thetaSpeed * -1
         end

         table.insert(planes, Plane(color, planeImages[color], planes.trail,
          constants.SCREEN.x / 1.8, math.random(1,6), math.random(-20, -10),
          thetaSpeed))
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
            local died, matched = plane:getShot(bullet)
            if died then
               if matched then
                  table.insert(booms, Explosion(booms.image, plane_position))
               else
                  table.insert(poofs, Poof(poofs.image, plane_position))
               end
               table.remove(planes, j)
            end
               table.remove(bullets, i)
         end
      end
   end

   -- Collision detection between planes and snake!
   for i, plane in ipairs(planes) do
      local plane_position = plane.position + center
      local distance = (plane_position - snake.position):len()
      if distance < constants.BULLET_RADIUS + constants.SNAKE_RADIUS then
         plane:crashIntoSnake()
         earthquake:shake(constants.CAMERA_SHAKE)
         table.insert(firejets, FireJet(firejets.image, plane_position))
         table.remove(planes,i)
      end
   end

   if (snakeHealth <= 0) then
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
   for i, firejet in ipairs(firejets) do
      if firejet.active then
         firejet:update(dt)
      else
         table.remove(firejets, i)
      end
   end

end

-- Called when this state is drawn.
function play:draw()
   background:draw()

   for i, firejet in ipairs(firejets) do
      firejet:draw()
   end

   for i, plane in ipairs(planes) do
      plane:draw()
   end

   snake:draw()

   player:draw()

   for i, bullet in ipairs(bullets) do
      bullet:draw()
   end

   for i, boom in ipairs(booms) do
      boom:draw()
   end
   for i, poof in ipairs(poofs) do
      poof:draw()
   end

   camera:detach()
   hud:draw(snakeHealth,score)   
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
      table.insert(bullets, Bullet(bullets.images, location, direction,
         snake:getCurrentColor(player.theta)))
   end
end

-- Used for idiomatic module loading.
return play
