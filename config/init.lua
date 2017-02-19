-- hs.hotkey.bind(mods, key, message, pressedfn, releasedfn, repeatfn) -> hs.hotkey object
-- Parameters:
--   mods - A table or a string containing (as elements, or as substrings with any separator) the keyboard modifiers required, which should be zero or more of the following:
--     "cmd", "command" or "⌘"
--     "ctrl", "control" or "⌃"
--     "alt", "option" or "⌥"
--     "shift" or "⇧"
--   key - A string containing the name of a keyboard key (as found in hs.keycodes.map ), or a raw keycode number
--   message - A string containing a message to be displayed via hs.alert() when the hotkey has been triggered, or nil for no alert
--   pressedfn - A function that will be called when the hotkey has been pressed, or nil
--   releasedfn - A function that will be called when the hotkey has been released, or nil
--   repeatfn - A function that will be called when a pressed hotkey is repeating, or nil

local function openAppFunc(app)
  local command = "open '/Applications/"..app..".app'"
  return function()
    hs.execute(command)
  end
end

local function inputKey(modifiers, key)
  hs.eventtap.event.newKeyEvent(modifiers, key, true):post()
  hs.timer.usleep(1000)
  hs.eventtap.event.newKeyEvent(modifiers, key, false):post()
end

local function inputKeyFunc(modifiers, key)
  return function() inputKey(modifiers, key) end
end

local function currentBundleID()
  focused = hs.window.focusedWindow()
  app = hs.window.application(focused)
  return hs.application.bundleID(app)
end

hs.hotkey.bind({'ctrl'}, 'h', nil, openAppFunc('Utilities/Terminal'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'o', nil, openAppFunc('Nocturn'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'u', nil, openAppFunc('Google Chrome'), nil, nil)

hs.hotkey.bind(
  {'cmd'}, 's', nil,
  function()
    if currentBundleID() == 'com.google.Chrome' then
      inputKey({'cmd'}, 'f')
    else
      inputKey({'cmd'}, 's')
    end
  end, nil, nil
)
hs.hotkey.bind(
  {'cmd'}, 'o', nil,
  function()
    if currentBundleID() == 'com.apple.Terminal' then
      inputKey({'alt'}, 'o')
    else
      inputKey({'cmd', 'shift'}, '[')
    end
  end, nil, nil
)
hs.hotkey.bind(
  {'cmd'}, 'p', nil,
  function()
    if currentBundleID() == 'com.apple.Terminal' then
      inputKey({'alt'}, 'p')
    else
      inputKey({'cmd', 'shift'}, ']')
    end
  end, nil, nil
)
