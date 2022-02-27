local m = hs.hotkey.modal.new({}, nil)

m.name = "WindowMove"
m.version = "1.0"
m.author = "Trung H.Tran <trungth.233@gmail.com>"

m.isOpen = false

function m:entered()
  hs.window.highlight.start()

  m.isOpen = true
  m.alertUuids = hs.fnutils.map(hs.screen.allScreens(), function(screen)
    local prompt = string.format("🖥 : %s",
                                 hs.window.focusedWindow():application():title())
    return hs.alert.show(prompt, hs.alert.defaultStyle, screen, true)
  end)

  return self
end

function m:exited()
  hs.window.highlight.stop()

  m.isOpen = false
  hs.fnutils.ieach(m.alertUuids, function(uuid)
    hs.alert.closeSpecific(uuid)
  end)

  return self
end

function m:toggle()
  if m.isOpen then
    m:exit()
  else
    m:enter()
  end

  return self
end

m.grid = {
  { key='j', unit=hs.layout.left70 },
  { key='k', unit=hs.layout.right30 },
  -- { key='h', unit=hs.layout.left50 },
  { key='h', unit=hs.geometry.rect(0,0,0.6,1) },
  { key='l', unit=hs.geometry.rect(0.6,0,0.4,1) },

  { key='y', unit=hs.geometry.rect(0, 0, 0.5, 0.5) },
  { key='u', unit=hs.geometry.rect(0.5, 0, 0.5, 0.5) },
  { key='b', unit=hs.geometry.rect(0, 0.5, 0.5, 0.5) },
  { key='n', unit=hs.geometry.rect(0.5, 0.5, 0.5, 0.5) },


  { key='space', unit=hs.layout.maximized },
}

function m:split()
  local windows = hs.fnutils.map(hs.window.orderedWindows(), function(win)
    if win ~= hs.window.focusedWindow() then
      return {
        text = win:title(),
        subText = win:application():title(),
        image = hs.image.imageFromAppBundle(win:application():bundleID()),
        id = win:id()
      }
    end
  end)

  local chooser = hs.chooser.new(function(choice)
    if choice ~= nil then
      local focused = hs.window.focusedWindow()
      local toRead  = hs.window.find(choice.id)
      if hs.eventtap.checkKeyboardModifiers()['alt'] then
        hs.layout.apply({
          {nil, focused, focused:screen(), hs.layout.left70, 0, 0},
          {nil, toRead, focused:screen(), hs.layout.right30, 0, 0}
        })
      else
        hs.layout.apply({
          {nil, focused, focused:screen(), hs.layout.left50, 0, 0},
          {nil, toRead, focused:screen(), hs.layout.right50, 0, 0}
        })
      end
      toRead:raise()
      focused:focus()
    end
  end)

  chooser
    :placeholderText("Choose window for 50/50 split. Hold ⎇ for 70/30.")
    :searchSubText(true)
    :choices(windows)
    :show()
end

function m:start()
  -- disable animations
  hs.window.animationDuration = 0

  hs.fnutils.each(m.grid, function(entry)
    m:bind('shift', entry.key, function()
      local focused = hs.window.focusedWindow()
      hs.layout.apply({
        {nil, focused, focused:screen():next(), entry.unit, 0, 0},
      })
      m:exit()
    end)
    m:bind('', entry.key, function()
      local focused = hs.window.focusedWindow()
      focused:move(entry.unit)
      -- hs.layout.apply({
      --   {nil, focused, focused:screen(), entry.unit, 0, 0},
      -- })
      m:exit()
    end)
  end)

  -- provide alternate escapes
  m
  :bind('ctrl', '[', function() m:exit() end)
  :bind('', 'escape', function() m:exit() end)

  return self
end

function m:bindHotKeys(mapping)
  local spec = {
    toggle = hs.fnutils.partial(self.toggle, self)
  }

  hs.spoons.bindHotkeysToSpec(spec, mapping)

  return self
end

return m
