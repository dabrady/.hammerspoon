-- Hammerspoon base config
hs.logger.setGlobalLogLevel('debug')
hs.window.animationDuration = 0.0
require("hs.ipc")

do
  package.path = ''
    ..'lib/?.lua;'
    ..'/Users/daniel.brady/github/?/?.lua;'
    ..package.path
  OLD_PATH = package.path
end

-------------------------
-- Load all the things --

-- Custom extensions for console use
do
  -- scope 'fs' to do-block
  local fs = require('lua-utils/hammerspoon/fs')
  -- expose 'my' as new global variable
  my = fs.loadAllFiles('lib/lua-utils', '.lua')
end

do
  HS_PRINT = print
  HS_TOSTRING = tostring
  -- Wrap HS implementation of 'print'
  local function make_formatter(depth)
    local function f(...)
      local args = table.pack(...)
      local strings = {}
      for _,arg in ipairs(args) do
        local str
        local meta = getmetatable(arg)
        if meta ~= nil and meta.__tostring ~= nil then
          str = HS_TOSTRING(arg)
        else
          str = my.table.format(arg, { depth = depth })
        end

        table.insert(strings, str)
      end

      return strings
    end

    return f
  end
  function print(...) return HS_PRINT(table.unpack(make_formatter(2)(...))) end
  end
end

WindowMgr = require('scripts/window_management')
-- MC = require('scripts/microphone_controller')

ConfigWatcher = require('scripts/config_watcher')
-- WifiWatcher = require('scripts/wifi_watcher')
-- HeadphoneWatcher = require('scripts/headphone_watcher')
-- SpotifyListener = require('scripts/spotify_listener')
-- KeyboardLayoutWatcher = require('scripts/keyboard_layout_watcher')
-- DvorakWatcher = require('scripts/dvorak_watcher')

-- UNDER CONSTRUCTION --
-- BluetoothWatcher = require('scripts/bluetooth_watcher')
Flow = hs.loadSpoon('Flow'):bindHotkeys({
    showFlowPalette = {{'ctrl', 'alt', 'cmd'}, 'space'}
})
-- Mode = hs.loadSpoon('Mode')
-- Mode:availableModes()['Work']:enter()

-----

--------------------------
-- Start all the things --
local modsToStart = {
  ConfigWatcher,
  -- WifiWatcher,
  -- HeadphoneWatcher,
  -- BluetoothWatcher,
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
