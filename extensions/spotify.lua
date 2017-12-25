local spotify_ext = {}
local tell = require('extensions.application').tell

spotify_ext.tell = function(...)
  tell('Spotify', ...)
end

------

return spotify_ext
