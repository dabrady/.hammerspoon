hs.keycodes.inputSourceChanged(
  function()
    local newLayout = hs.keycodes.currentLayout()
    if newLayout == "U.S." then
      newLayout = 'QWERTY'
    end

    hs.notify.new({
      title="keyboard changed",
      subTitle=newLayout,
      contentImage=hs.keycodes.iconForLayoutOrMethod(newLayout)
    }):send()
  end)
