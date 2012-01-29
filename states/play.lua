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
local sound = require "sound"
local ChainWave = require "entities.chain_wave"

-- The player's score and multiplier.
score = 0
multiplier = 1
-- The snake should start with its max health.
snakeHealth = constants.SNAKE_MAX_HEALTH
-- Start off with 0 planes in the game.
numPlanes = 0
-- Start off wanting 1 plane in the game.
numPlanesToHave = 1
-- The number of planes that the player has destroyed so far.
numPlanesDestroyed = 0
-- Start at 1, and get harder by 0.1 for every 15 planes destroyed.
numPlanesDestroyedDifficultyMultiplier = 1
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
local chainwaves = {}
local awesomes = {}
local chain_font = {}

-- Initialize the state. Called once when it's first created.
function play:init()
   -- Camera is looking at the center of the window.
   camera = Camera(constants.CENTER:clone(), 1, 0)
   earthquake = Earthquake(camera)

   chain_font = love.graphics.newFont("fonts/white_rabbit.ttf", 96)

   -- Load the background.
   background = Background(camera)

   -- Create the snake.
   snake = Snake(love.graphics.newImage("images/oroborous_small.png"))

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

   -- Load the particle trail image.
   planes.trail = love.graphics.newImage("images/particle.png")

   -- Prep the effects.
   booms.image = love.graphics.newImage("images/particle.png")
   poofs.image = love.graphics.newImage("images/particle.png")
   firejets.image = love.graphics.newImage("images/particle.png")

   hud = Hud()
end

-- Called when this state is entered with the previous state.
function play:enter(previous)
   snakeHealth = constants.SNAKE_MAX_HEALTH
   score = 0

   sound.playMusic()

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
         -- The first of two params is the minimum absolute thetaSpeed, &
         -- the second param is the maximum absolute thetaSpeed.
         local thetaSpeed = math.random(15, 80) / 120 
         -- Give a 50% chance to make it go the opposite direction.
         if (math.random(1,2) == 1) then
            thetaSpeed = thetaSpeed * -1
         end

         local rSpeed = math.random(-21, -12)

         table.insert(planes, Plane(color, planeImages[color], planes.trail,
          constants.SCREEN.x / 1.9, math.random(1,6), rSpeed,
          thetaSpeed * numPlanesDestroyedDifficultyMultiplier))
      end
   end

   -- Give a low chance per update to increase the maximum allowed # of planes
   if (math.random(1,100) <= constants.INCREASE_MAX_ENEMY_COUNT_CHANCE * numPlanesDestroyedDifficultyMultiplier) then
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

            if matched == false then
               sound.smallExplosion()
            end

            if died then
               if matched then
                  table.insert(booms, Explosion(booms.image, plane_position, plane.color))
                  table.insert(chainwaves, ChainWave(chain_font, plane_position, plane.color))
                  sound.bigExplosion()
               else
                  score = score + 10
                  table.insert(poofs, Poof(poofs.image, plane_position))
               end
               table.remove(planes, j)
            end
               table.remove(bullets, i)
         end
      end
   end

   local minPlaneDist = 99999;

   -- Collision detection between planes and snake!
   for i, plane in ipairs(planes) do
      local plane_position = plane.position + center
      local distance = (plane_position - snake.position):len()

      if (plane.r - constants.SNAKE_RADIUS) < minPlaneDist then
         minPlaneDist = plane.r - constants.SNAKE_RADIUS
      end

      -- BULLET_RADIUS because it's small. Plane would be too big.
      if distance < constants.BULLET_RADIUS + constants.SNAKE_RADIUS then
         plane:crashIntoSnake()
         earthquake:shake(constants.CAMERA_SHAKE)
         sound.snakeHit()
         table.insert(firejets, FireJet(firejets.image, plane_position))
         table.remove(planes,i)
      end
   end

   -- sound.warningBeep(minPlaneDist)

   if (snakeHealth <= 0) then
      Gamestate.switch(gameover, hud, planes, score)
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
   for i, chainwave in ipairs(chainwaves) do
      if chainwave.active then
         chainwave:update(dt, planes, booms, awesomes, chainwaves)
      else
         table.remove(chainwaves, i)
         if #chainwaves <= 0 then
            multiplier = 1
         end
      end
   end
   for i, awesome in ipairs(awesomes) do
      if awesome.active then
         awesome:update(dt)
      else
         table.remove(awesomes, i)
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

   snake:draw(snakeHealth)

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
   for i, chainwave in ipairs(chainwaves) do
      chainwave:draw()
   end
   for i, awesome in ipairs(awesomes) do
      awesome:draw()
   end

   camera:detach()
   hud:draw(snakeHealth,score)   
end

function play:mousepressed(x, y, button)
   if button == "wd" then
      -- Double the spin effect if it came from the mouse.
      snake:spinCW(1)
   end
   if button == "wu" then
      -- Double the spin effect if it came from the mouse.
      snake:spinCCW(1)
   end

   if button == "l" then
      local direction = player.position:normalized()
      local location = (constants.SCREEN / 2) + player.position +
         (direction * player.SIZE.y)
      table.insert(bullets, Bullet(bullets.images, location, direction,
         snake:getCurrentColor(player.theta)))
      sound.bulletFire()
   end
end

--[[
function play:keypressed(key, unicode)
   if (love.keyboard.isDown("spacebar") or butto) then
      local direction = player.position:normalized()
      local location = (constants.SCREEN / 2) + player.position +
         (direction * player.SIZE.y)
      table.insert(bullets, Bullet(bullets.images, location, direction,
         snake:getCurrentColor(player.theta)))
   end
end
]]

-- Used for idiomatic module loading.
return play
