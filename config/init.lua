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

local function openApp(app)
  local command = "open '/Applications/"..app..".app'"
  return function()
    hs.execute(command)
  end
end

local function inputKey(modifiers, key)
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, key, true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, key, false):post()
  end
end

hs.hotkey.bind({'ctrl'}, 'h', nil, openApp('Utilities/Terminal'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'o', nil, openApp('Nocturn'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'u', nil, openApp('Google Chrome'), nil, nil)

hs.hotkey.bind({'cmd'}, 'o', nil, inputKey({'alt'}, 'o'), nil, nil)
hs.hotkey.bind({'cmd'}, 'p', nil, inputKey({'alt'}, 'p'), nil, nil)
