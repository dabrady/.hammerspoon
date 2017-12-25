local micImage = hs.image.imageFromName('NSTouchBarAudioInputTemplate')
local mutedMicImage = hs.image.imageFromName('NSTouchBarAudioInputMuteTemplate')
local builtinMicrophoneUID = 'AppleHDAEngineInput:1B,0,1,0:1'
local microphone = hs.audiodevice.findDeviceByUID(builtinMicrophoneUID)

local function _calculateCanvasFrame()
  -- local default = {x = 620, y = 560, w = 200, h = 200}
  local focusedApp = hs.application.frontmostApplication()
  local canvasWidth = 200
  local canvasHeight = 200
  local screenFrame

  -- Intentionally not using `hs.screen.mainScreen()` when focused app is not 'Finder', because it seems to be
  -- circumvented when using Hammerspoon to move windows from one screen to another. In all other cases, the main
  -- screen is always going to be the screen on which the currently focused application resides.
  if focusedApp:name() == 'Finder' then
    screenFrame = hs.screen.mainScreen():frame()
  elseif focusedApp:mainWindow() then
    screenFrame = focusedApp:mainWindow():screen():frame()
  else
    -- Something's wrong.
    return {x = 0, y = 0, w = canvasWidth, h = canvasHeight}
  end

  -- Center point should be at roughly: {x = (screenWidth / 2), y = (screenHeight * 3/4)}
  return {
    x = screenFrame.center.x - (canvasWidth / 2) - 2, -- Center horizontally relative to focused screen
    y = (screenFrame.y + screenFrame.h) - (canvasHeight * 1.7),
    w = canvasWidth,
    h = canvasHeight
  }
end

microphoneOverlay = my.canvas.flashable(hs.canvas.new(_calculateCanvasFrame()):appendElements({
  {
    type = "image",
    image = micImage,
    imageScaling = "scaleProportionally",
    imageAlignment = 'center',
    imageAlpha = 1.0
  },
  {
    type = "rectangle",
    action = "fill",
    compositeRule = "sourceAtop",
    fillColor = hs.drawing.color.colorsFor('System').gridColor
  },
  -- {
  --   type = "rectangle",
  --   action = "fill",
  --   compositeRule = "destinationOver",
  --   fillColor = {alpha = 0.8}
  -- }
}))

local function _mute()
  if not microphone:inputMuted() then
    microphone:setInputMuted(true)
    microphoneOverlay.canvas[1].image = mutedMicImage
  end
  microphoneOverlay:flash()
end

local function _unmute()
  if microphone:inputMuted() then
    microphone:setInputMuted(false)
    microphoneOverlay.canvas[1].image = micImage
  end
  microphoneOverlay:flash()
end

hs.hotkey.bind({}, 'f10', function()
  microphoneOverlay.canvas:frame(_calculateCanvasFrame())
  if microphone:inputMuted() then
    _unmute()
  else
    _mute()
  end
end)
