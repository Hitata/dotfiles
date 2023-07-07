-- Load preferences
require('preferences')

hs.loadSpoon('Hyper')
-- hs.loadSpoon('WindowMove')
hs.loadSpoon('MiroWindowsManager')

App   = hs.application
Hyper = spoon.Hyper

Hyper:bindHotKeys({hyperKey = {{}, 'F19'}})


-- Finding application bundleID
-- hs.application.find('notion'):bundleID()
--
--
helpers = {}
helpers.get_window = function(callback)
  local win = hs.window.frontmostWindow()
  if not win then return end
  callback(win)
end


-- shortkey to hammerspoon
Hyper:bind({'shift'}, 'r', function()
  hs.reload()
end)
Hyper:bind({'shift'}, 't', function()
  hs.console.clearConsole()
  hs.toggleConsole()
  helpers.get_window(function(win) win:focus()end)
end)

-- shortkey to application
Hyper:bind({}, '1', function()
  App.launchOrFocusByBundleID('net.kovidgoyal.kitty')
end)

Hyper:bind({}, '2', function()
  App.launchOrFocusByBundleID('com.brave.Browser')
end)

Hyper:bind({}, '3', function()
  App.launchOrFocusByBundleID('notion.id')
end)

Hyper:bind({}, '4', function()
  App.launchOrFocusByBundleID('com.tinyspeck.slackmacgap')
end)

-- MoveWindows = spoon.WindowMove
-- hs.window.highlight.ui.overlay = true
-- MoveWindows
--   :start()
--   :bind('', ',', function()
--     hs.window.focusedWindow()
--       :application()
--       :selectMenuItem("Tile Window to Left of Screen")
--     MoveWindows:exit()
--   end)
--   :bind('', '.', function()
--     hs.window.focusedWindow()
--       :application()
--       :selectMenuItem("Tile Window to Right of Screen")
--     MoveWindows:exit()
--   end)
--   :bind('', 'v', function()
--     MoveWindows:split()
--     MoveWindows:exit()
--   end)
--   :bind('', 'tab', function ()
--     hs.window.focusedWindow():centerOnScreen()
--     MoveWindows:exit()
--   end)

-- Hyper:bind({}, 'm', function() MoveWindows:toggle() end)
local hyper = {"alt", "cmd"}
hs.window.animationDuration = 0.3
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"},
  nextscreen = {hyper, "n"}
})

