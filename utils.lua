local Vector = require "hump.vector"

function polarToCartesian(r, theta)
   return Vector(r * math.cos(theta), r * math.sin(theta));
end
