local reloadConfiguration = hs.loadSpoon('ReloadConfiguration')
reloadConfiguration:bindHotkeys({
  reloadConfiguration = {{'cmd', 'alt', 'ctrl'}, 'R'}
})

------

return reloadConfiguration
