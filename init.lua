-- Hammerspoon base config
HS_PRINT = print
hs.logger.setGlobalLogLevel('debug')
hs.window.animationDuration = 0.0
require("hs.ipc")

package.path = 'lib/?.lua;lib/lua-utils/?.lua;lib/lua-utils/?/?.lua;'..package.path

-------------------------
-- Load all the things --

-- Custom extensions for console use
do
  -- scope 'fs' to do-block
  local fs = require('lua-utils/hammerspoon/fs')
  print('\t-- loading custom extensions')
  -- expose 'my' as new global variable
  my = fs.loadAllFiles('lib/lua-utils', '.lua')
end
-- Replace HS implementation of 'print'
function make_printer(depth)
  return function(...)
    local args = table.pack(...)
    local strings = {}
    for _,arg in ipairs(args) do
      local str
      local meta = getmetatable(arg)
      if meta ~= nil and meta.__tostring ~= nil then
        str = tostring(arg)
      else
        str = my.table.format(arg, depth)
      end

      table.insert(strings, str)
    end
    HS_PRINT(table.unpack(strings))
  end
end
function print(...) return make_printer(2)(...) end

WindowMgr = require('scripts/window_management')
MC = require('scripts/microphone_controller')

ConfigWatcher = require('scripts/config_watcher')
WifiWatcher = require('scripts/wifi_watcher')
HeadphoneWatcher = require('scripts/headphone_watcher')
SpotifyListener = require('scripts/spotify_listener')
-- KeyboardLayoutWatcher = require('scripts/keyboard_layout_watcher')
-- DvorakWatcher = require('scripts/dvorak_watcher')

Mode = hs.loadSpoon('Mode')
-- local work = Mode:availableModes()['Work']
-- work:enter()

--------------------------
-- Start all the things --
local modsToStart = {
  -- ConfigWatcher,
  WifiWatcher,
  HeadphoneWatcher,
  -- DvorakWatcher,
  -- SpotifyListener
}
hs.fnutils.each(modsToStart, function(module) module:start() end)

-------------------------------------
-- Stop all the things on shutdown --
hs.shutdownCallback = function()
  hs.fnutils.each(modsToStart, function(module) module:stop() end)
end

-------
hs.notify.new({
  title="Config Refreshed"
}):send()
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
