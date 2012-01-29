-- Require any needed modules.
local Class = require "hump.class"
local Vector = require "hump.vector"
local Camera = require "hump.camera"
local constants = require "constants"

-- Define the class (and constructor).
local Earthquake = Class(function(self, camera)
   self.camera = camera
   self.time = 0
   self.spring_k = 0.9
   self.friction = 0.93
   self.trans_vel = Vector(0, 0)
   self.zoom_vel = 0
end)

function Earthquake:update(dt)
   self.time = self.time + dt

   local a = (constants.CENTER - self.camera.pos) * self.spring_k
   self.trans_vel = (self.trans_vel + a) * self.friction
   self.camera.pos = self.camera.pos + self.trans_vel * dt

   local b = (1 - self.camera.zoom) * self.spring_k
   self.zoom_vel = (self.zoom_vel + b) * self.friction
   self.camera.zoom = self.camera.zoom + self.zoom_vel * dt
end

function Earthquake:shake(magnitude)
   local direction = Vector(math.random() - 0.5, math.random() - 0.5):normalize_inplace()
   self.camera.pos = self.camera.pos + direction * magnitude
   self.camera.zoom = 1 + (0.5 - math.random()) * 0.25
end

-- Used for idiomatic module loading.
return Earthquake
