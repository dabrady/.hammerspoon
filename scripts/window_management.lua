--[[

----------------------------------------------
|              |      ||      |              |   alt +
|                     ||                     |     R -> top left 1/4
|              |      ||      |              |     U -> top right 1/4
|                     ||                     |     V -> bottom left 1/4
|              |      ||      |              |     M -> bottom right 1/4
|---------------------||---------------------|     F -> left 1/3 (, then left 2/3, and cycle)
|              |      ||      |              |     J -> right 1/3 (, then right 2/3, and cycle)
|                     ||                     |     G -> left 1/2
|              |      ||      |              |     H -> right 1/2
|                     ||                     |     T -> top 1/2
|              |      ||      |              |     N -> bottom 1/2
----------------------------------------------     Y -> top 1/3 (, then top 2/3, and cycle)
                                                   B -> bottom 1/3 (, then bottom 2/3, and cycle)
                                                   ` -> maximize (, then back to previous, and cycle)
                                                   CMD + C -> center horizontally
                                                   CMD + Z -> undo
--]]
hs.window.animationDuration = 0 -- No resizing animations
hs.loadSpoon('WindowHalfsAndThirds')
  :bindHotkeys({
    top_left    = { {'alt'}, 'R' },
    top_right   = { {'alt'}, 'U' },
    bottom_left = { {'alt'}, 'V' },
    bottom_right= { {'alt'}, 'M' },
    third_left  = { {'alt'}, 'F' },
    third_right = { {'alt'}, 'J' },
    left_half   = { {'alt'}, 'G' },
    right_half  = { {'alt'}, 'H' },
    top_half    = { {'alt'}, 'T' },
    bottom_half = { {'alt'}, 'N' },
    third_up    = { {'alt'}, 'Y' },
    third_down  = { {'alt'}, 'B' },
    max_toggle  = { {'alt'}, '`' },
    max         = { {'alt', 'cmd'}, 'Up' },
    undo        = { {'alt', 'cmd'}, 'z' },
    center      = { {'alt', 'cmd'}, 'c' },
    larger      = { {'alt', 'cmd'}, 'Right' },
    smaller     = { {'alt', 'cmd'}, 'Left' },
 })


hs.loadSpoon('WindowScreenLeftAndRight')
  :bindHotkeys({
    screen_left = { {"ctrl", "alt", "cmd", "shift"}, "Left" },
    screen_right= { {"ctrl", "alt", "cmd", "shift"}, "Right" }
  })
