local projectWatcher = hs.pathwatcher.new(
  os.getenv("HOME").."/projects/beginners_guide_to_react",
  function(files)
    local chrome = hs.application.get('Google Chrome')
    local currentApp = hs.application.frontmostApplication()
    local serverWindow = chrome:getWindow('127.0.0.1:8887')
    if serverWindow ~= nil then
      chrome:activate()
      serverWindow:focus()
      chrome:selectMenuItem({"View", "Reload This Page"})
      currentApp:activate()
    end
  end)

------

return projectWatcher
