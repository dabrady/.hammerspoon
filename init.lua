hs.logger.setGlobalLogLevel('debug')

-- An alias for utility functions
my = hs.loadSpoon('Utilities').utils

require('scripts/window_management')
require('scripts/microphone_controller')

-- require('scripts/config_watcher'):start()
require('scripts/wifi_watcher'):start()
--  require('project_watcher'):start()
require('scripts/headphone_watcher'):start()
require('scripts/spotify_listener'):start()


-----
Mode = hs.loadSpoon('Mode')
-- local work = Mode:availableModes()['Work']
-- work:enter()



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
