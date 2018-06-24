local dvorakWatcher = hs.application.watcher.new(
  function(name, eventType, _)
    if eventType == hs.application.watcher.activated then
      if name == "Emacs" then
        hs.keycodes.setLayout("Programmer Dvorak")
      else
        if hs.keycodes.currentLayout() ~= "U.S." then
          hs.keycodes.setLayout("U.S.")
        end
      end
    end
  end)

------

return dvorakWatcher
