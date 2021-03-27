local hsb = require('hs._db.bluetooth')
local my = {spotify = require('lib/lua-utils/hammerspoon/spotify')}
local function sleep(n)
  local t0 = os.clock()
  while os.clock() - t0 <= n do end
end

local function reactToAudioDevice(deviceProperties)
  print(deviceProperties)
  if deviceProperties.deviceClass == 'audio' then
    -- Audio device connected
    if deviceProperties.isConnected then
      -- Wait a second for the OS to swap audio outputs.
      sleep(1)

      -- Autoplay Spotify.
      if not hs.spotify.isPlaying() then
        my.spotify.tell('play')
      end
    else -- Audio device disconnected
      if hs.spotify.isPlaying() then
        my.spotify.tell('pause')
      end
    end
  end
end

------

local bluetoothWatcher = hsb.newWatcher(reactToAudioDevice)
  :devicePropertiesToQuery(
    {
      "deviceCategory",
      "classOfDevice",
      "isConnected",
      "name",
      "lastNameUpdate"
    }
);
return bluetoothWatcher
