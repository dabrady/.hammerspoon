local lastSSID = hs.wifi.currentNetwork()
local function handleSSIDChange()
  local newSSID = hs.wifi.currentNetwork()
  if newSSID == nil then return end

  if newSSID ~= lastSSID then
    -- We just joined a new network; celebrate.
    hs.alert("Now connected to "..newSSID)
    lastSSID = newSSID
  end
end

------

return hs.wifi.watcher.new(handleSSIDChange)
