-- Hammerspoon base config
hs.logger.setGlobalLogLevel('debug')
hs.window.animationDuration = 0.0

-------------------------
-- Load all the things --

-- Custom extensions for console use
do
  -- scope 'fs' to do-block
  local fs = require('extensions/fs')
  print('\t-- loading custom extensions')
  -- expose 'my' as new global variable
  my = fs.loadAllScripts('extensions')
end

WindowMgr = require('scripts/window_management')
MC = require('scripts/microphone_controller')

-- ConfigWatcher = require('scripts/config_watcher')
WifiWatcher = require('scripts/wifi_watcher')
HeadphoneWatcher = require('scripts/headphone_watcher')
SpotifyListener = require('scripts/spotify_listener')

Mode = hs.loadSpoon('Mode')
-- local work = Mode:availableModes()['Work']
-- work:enter()

--------------------------
-- Start all the things --
local modsToStart = {
  -- ConfigWatcher,
  WifiWatcher,
  HeadphoneWatcher,
  -- SpotifyListener
}
hs.fnutils.each(modsToStart, function(module) module:start() end)

-------------------------------------
-- Stop all the things on shutdown --
hs.shutdownCallback = function()
  hs.fnutils.each(modsToStart, function(module) module:stop() end)
end

-------
hs.alert.show('Config refreshed')
-------


--[[ NOTE https://github.com/szymonkaliski/Dotfiles/blob/master/Dotfiles/hammerspoon

-------------------------
-- Load all the things --
bindings     = require('')
controlplane = require('')
notify       = require('')
watchers     = require('')
window       = require('')
mode         = hs.loadSpoon('Mode')

------------------------------
-- Configure all the things --

-- hs
hs.window.animationDuration = 0.0

-- watchers
watchers.enabled = {'wifi', 'bluetooth', 'config'}

local modsToStart = {
  bindings,
  controlplane,
  notify,
  watchers
}

--------------------------
-- Start all the things --
hs.fnutils.each(modsToStart, function(module) module.start() end)

-------------------------------------
-- Stop all the things on shutdown --
hs.shutdownCallback = function()
  -- save window positions in hs.settings
  window.persistPosition('store')

  hs.fnutils.each(modsToStart, function(module) module.stop() end)
end

]]
