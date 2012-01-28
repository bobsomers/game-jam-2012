-- Require any needed modules.
local Vector = require "hump.vector"

-- The "module" (it's actually just a table used as a namespace).
local utils = {}

-- Takes a set of polar coordinates and converts them to cartesian coordinates.
function utils.polarToCartesian(r, theta)
   return Vector(r * math.cos(theta), r * math.sin(theta))
end

-- Used for idiomatic module loading.
return utils
