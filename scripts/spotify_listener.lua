local my = {spotify = require('extensions.spotify')}

--- The hisses are too sensitive for an environment where lots of sound can reach the microphone.
-- local BEGIN_HISS = 1
-- local END_HISS = 2
local POP = 3

-- Creates a noise listener which plays/pauses
local listener = hs.noises.new(
  function(eventID)
    if eventID == POP then
      if hs.spotify.isRunning() then
        my.spotify.tell('playpause')
        if hs.spotify.isPlaying() then
          hs.alert('playing', 0.3)
        else
          hs.alert('paused', 0.3)
        end
      else
        hs.alert('starting spotify', 0.6)
        my.spotify.tell('play')
      end
    end
  end
)

------

return listener
