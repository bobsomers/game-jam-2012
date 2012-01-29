local sound = {}

local music = {}
local walks = {}

-- Load all sounds here. Call only once
function sound.init() 
   music = {
      menu = love.audio.newSource("sounds/menu.ogg", "stream"),
      game = love.audio.newSource("sounds/music.ogg", "stream")
   }
   music.menu:setLooping(true)
   music.game:setLooping(true)

   walks = {
      love.audio.newSource("sounds/walk_1.wav", "static"),
      love.audio.newSource("sounds/walk_2.wav", "static"),
      love.audio.newSource("sounds/walk_3.wav", "static"),
      love.audio.newSource("sounds/walk_4.wav", "static"),
      love.audio.newSource("sounds/walk_5.wav", "static"),
      time = 0,
      last = 0
   }

   smallExplosions = {
      love.audio.newSource("sounds/explosion_1.wav", "static"),
      love.audio.newSource("sounds/explosion_2.wav", "static"),
      love.audio.newSource("sounds/explosion_3.wav", "static"),
      love.audio.newSource("sounds/explosion_4.wav", "static")
   }
   
   bigExplosions = {
      love.audio.newSource("sounds/big_explosion_1.wav", "static"),
      love.audio.newSource("sounds/big_explosion_2.wav", "static"),
      love.audio.newSource("sounds/big_explosion_3.wav", "static"),
      love.audio.newSource("sounds/big_explosion_4.wav", "static")
   }

   bulletFireSound = love.audio.newSource("sounds/bullet_fire.wav", "static");
   warningBeep = love.audio.newSource("sounds/warning_beep.wav", "static");
   motherfuckinSound = love.audio.newSource("sounds/motherfuckin.wav", "static");
   snakeHitSound = love.audio.newSource("sounds/snake_hit.wav", "static");

   warningBeep:setLooping(true)
   warningPlaying = false
end

function sound.playMenu()
   love.audio.stop(music.game)
   love.audio.play(music.menu)
end

function sound.playMusic()
   love.audio.stop(music.menu)
   love.audio.play(music.game)
end

function sound.walk(dt)
   walks.time = walks.time + dt
   if walks.time - walks.last > 0.25 then
      local which = walks[math.random(1, 5)]
      love.audio.stop(which)
      love.audio.rewind(which)
      love.audio.play(which)
      walks.last = walks.time
   end
end

function sound.snakeHit()
   love.audio.stop(snakeHitSound)
   love.audio.rewind(snakeHitSound)
   love.audio.play(snakeHitSound)
end

function sound.motherfuckin()
   love.audio.stop(motherfuckinSound)
   love.audio.rewind(motherfuckinSound)
   love.audio.play(motherfuckinSound)
end

function sound.bulletFire()
   love.audio.stop(bulletFireSound)
   love.audio.rewind(bulletFireSound)
   love.audio.play(bulletFireSound)
end

function sound.smallExplosion() 
   local which = smallExplosions[math.random(1, 4)]
   love.audio.stop(which)
   love.audio.rewind(which)
   love.audio.play(which)
end

function sound.bigExplosion() 
   local which = bigExplosions[math.random(1, 4)]
   love.audio.stop(which)
   love.audio.rewind(which)
   love.audio.play(which)
end

function sound.warningBeep(planeDist)
   local minBeepDist = 200; -- px

   print ("min plane dist" .. planeDist)

   if planeDist > minBeepDist then
      love.audio.stop(warningBeep)
      warningPlaying = false
      return
   end
   
   -- love.audio.rewind(warningBeep)
   warningBeep:setLooping(true)
   love.audio.play(warningBeep)
   warningPlaying = true

   -- Go from 1.0 to 2.0
   local newPitch = (minBeepDist * 2) / (planeDist + minBeepDist)
   print ("new pitch " .. newPitch)

   warningBeep:setPitch(newPitch)
end

-- Used for idiomatic module loading.
return sound
