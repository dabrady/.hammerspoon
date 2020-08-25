local reloadConfiguration = hs.loadSpoon('ReloadConfiguration')
reloadConfiguration:bindHotkeys({
  reloadConfiguration = {{'cmd', 'alt', 'ctrl'}, 'R'}
})

-- Annoyingly, this spoon has as `start` without a `stop`, so I'm adding one to keep with the expectations of
-- a 'watcher' API.
function reloadConfiguration:stop()
  return nil
end
------

return reloadConfiguration
