-- Require any needed modules.
local Vector = require "hump.vector"

-- The "module" (it's actually just a table used as a namespace).
local constants = {}

-- The name of the game.
constants.TITLE = "Planes on a Snake"

-- The author of the game.
constants.AUTHOR = "CPGD"

-- The screen dimensions.
constants.SCREEN = Vector(1024, 768)

-- Are we in debug mode?
constants.DEBUG_MODE = true

-- The amount of health a plane has.
constants.PLANE_HEALTH = 100

-- How far away the player is from the center of the screen?
constants.PLAYER_DISTANCE = 100

-- How big is the player's image?
constants.PLAYER_SIZE = Vector(20, 40)

-- How fast does the player spin around the snake?
constants.PLAYER_SPIN_RATE = 1.5

-- How fast does the snake spin?
constants.SNAKE_SPIN_RATE = 1.5

-- How fast do bullets travel?
constants.BULLET_SPEED = 150

-- For collision detection purposes...
constants.BULLET_RADIUS = 5
constants.PLANE_RADIUS = 25

-- Used for idiomatic module loading.
return constants
