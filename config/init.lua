local function invoke(app)
  return function()
    hs.execute("open '/Applications/"..app..".app'")
  end
end

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
hs.hotkey.bind({'ctrl'}, 'h', nil, invoke('Utilities/Terminal'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'o', nil, invoke('Nocturn'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'u', nil, invoke('Google Chrome'), nil, nil)
