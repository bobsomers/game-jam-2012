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
constants.CENTER = constants.SCREEN / 2

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
constants.SNAKE_SPIN_RATE = 0.25

-- The maximum amount of health the snake can have.
constants.SNAKE_MAX_HEALTH = 100

-- How fast do bullets travel?
constants.BULLET_SPEED = 250

-- How big is a bullet?
constants.BULLET_SIZE = Vector(10, 10)

-- How much damage is dealt when the bullet and plane's colors match?
constants.BULLET_MATCHING_COLOR_DAMAGE = 100

-- How much damage is dealt when the bullet and plane have different colors?
constants.BULLET_NOT_MATCHING_COLOR_DAMAGE = 20

-- For collision detection purposes...
constants.BULLET_RADIUS = constants.BULLET_SIZE.x / 2
constants.PLANE_RADIUS = 50
constants.SNAKE_RADIUS = 110

-- What are the possible colors for enemies?
constants.ENEMY_COLORS = {"red", "green", "yellow", "blue"}

-- Integer  %. What chance is there per game update to increase the maximum
-- allowed # of enemies in the game.
constants.INCREASE_MAX_ENEMY_COUNT_CHANCE = 1;

-- Integer %. What chance is there per game update to spawn a new enemy that
-- is currently missing from the game.
constants.SPAWN_ENEMY_CHANCE = 1;

-- Magnitude of camera shake.
constants.CAMERA_SHAKE = 25

-- Used for idiomatic module loading.
return constants
