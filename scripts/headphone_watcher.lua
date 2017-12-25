local builtinOutputUID = 'AppleHDAEngineOutput:1B,0,1,1:0'
-- local builtinMicrophoneUID = 'AppleHDAEngineInput:1B,0,1,0:1'

local audioOutput = hs.audiodevice.findDeviceByUID(builtinOutputUID)
-- local microphone = hs.audiodevice.findDeviceByUID(builtinMicrophoneUID)

-- local function playpauseYouTube()
--   local chrome = hs.application.get('Google Chrome')
--   if chrome and chrome:findWindow('YouTube') then
--     print('Youtube is open!')
--     local playpause = hs.eventtap.event.newKeyEvent({}, 'k', true) -- YouTube responds to 'k' key-down as play/pause
--     playpause:post(chrome) -- Post the 'k' key-down only to Chrome; works even if Chrome is in the background!
--     return true
--   else
--     return false
--   end
-- end

local function reactToHeadphonePresence(deviceUID, event, scope, eventElement)
  if deviceUID ~= builtinOutputUID then return end -- Sanity check
  if event == 'jack' then
    -- Headphones connected
    if audioOutput:jackConnected() then
      -- Autoplay Spotify.
      if not hs.spotify.isPlaying() then
        my.spotify.tell('play')
      end
    else -- Headphones disconnected
      if hs.spotify.isPlaying() then
        my.spotify.tell('pause')
      end
    end
  end
end

audioOutput:watcherCallback(reactToHeadphonePresence)

local headphoneWatcher = {}
function headphoneWatcher:start()
  audioOutput:watcherStart()
end

------

return headphoneWatcher
