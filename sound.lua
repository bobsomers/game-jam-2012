local sound = {}

local music = {}
local walks = {}

-- Load all sounds here. Call only once
function sound.init() 
   music = {
      menu = love.audio.newSource("sounds/menu.mp3", "stream"),
      game = love.audio.newSource("sounds/music.mp3", "stream")
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

-- Used for idiomatic module loading.
return sound
