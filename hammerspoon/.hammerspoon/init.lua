hs.loadSpoon('Hyper')

App   = hs.application
Hyper = spoon.Hyper

Hyper:bindHotKeys({hyperKey = {{}, 'F19'}})

Hyper:bind({}, '1', function()
  App.launchOrFocusByBundleID('net.kovidgoyal.kitty')
end)
