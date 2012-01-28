# Global Game Jam 2012!!!

Good morning everyone! I did a lot of cleanup and clarification about some
Lua-related module things that were unclear yesterday. Check out one of the
classes (i.e. `entities/snake.lua`) as an example. Note that the class
"declaration" (and constructor) is now a local variable and that variable is
"returned" at the end of the file. This let's us do things like this:

    local MyClass = require "entities.myclass"

I also modified `utils.lua` to be a "module" of sorts (check the source) and
added a "constants" file to keep all our switches and dials in one place for
balancing and testing on Sunday.

Happy GGJ 2012!
