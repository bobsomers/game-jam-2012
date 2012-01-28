-- Let's use the class mechanism from HUMP.
local Class = require "hump.class"

-- And the vector helper!
local Vector = require "hump.vector"
love.filesystem.load("utils.lua")()

--[[
color is the color of the plane.
image is the already loaded image variable to be used for this plane
r is how far the plane should start from the center of the snake, in pixels
theta is the angle in radians 
rSpeed is the speed at which it decreases its distance to the snake, in pixels
(this should be negative)
thetaSpeed is the speed in radians / second at which the plane travels 
Positive thetaSpeed is counter-clockwise. Negative thetaSpeed = clockwise.
]]
Plane = Class(function(self, color, image, r, theta, rSpeed, thetaSpeed)
   self.color = color;
   self.image = image;
   self.r = r;
   self.theta = theta;
   -- What are the base r and theta speeds of our plane?
   self.rSpeed = rSpeed;
   self.thetaSpeed = thetaSpeed;
   self.health = 100;
end)

--[[
function Plane:reset()
self.position = Vector(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4)
self.direction = Vector((math.random() * 2) - 1, (math.random() * 2) - 1)
self.direction:normalize_inplace()
end
]]--

function Plane:update(dt)
   -- Update the radius and theta
   self.r = self.r + (dt * self.rSpeed);
   self.theta = self.theta + (dt * self.thetaSpeed);
end

function Plane:draw()
   local coordinates = polarToCartesian(self.r, self.theta);

   -- We'll "scale" our image on the Y axis by either +1 or -1, depending on
   -- which way the plane needs to be facing to look in his direction of travel.
   local facing = 1
   if self.thetaSpeed < 0 then
      facing = -1
   end

   -- TODO: REPLACE THESE CONSTANTS
   local centerX = 1024 / 2;
   local centerY = 768 / 2;

   local drawX = centerX + coordinates.x;
   local drawY = centerY + coordinates.y;

   local scale = 0.1;

   -- Draw the plane at position (coordinate.x, coordinate.y) with no rotation,
   -- 1.0 scale on the X axis and "facing" scale on the Y axis, 
   -- and defining the center of our plane to be in the center of the image.
   --(image, x, y, rotation, scaleX, scaleY, originOffsetX, originOffsetY)
   love.graphics.draw(self.image, drawX, drawY, self.theta, scale, 
   scale * facing, self.image:getWidth() / 2, self.image:getHeight() / 2);


   --[[
   -- Draw the enemy at position (x, y) with no rotation, 1.0 scale on the Y
   -- axis and "facing" scale on the X axis, and defining the center of our
   -- enemy to be in the center of the image.
   love.graphics.draw(self.images[self.level],
   self.position.x, self.position.y,
   0,
   facing, 1,
   self.images[self.level]:getWidth() / 2, self.images[self.level]:getHeight() / 2)
   ]]
end
