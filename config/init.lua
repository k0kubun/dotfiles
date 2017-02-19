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

local function bindAppSpecificRemapWithDefault(appBundleID, fromMods, fromKey, toMods, toKey, defaultMods, defaultKey)
  hs.hotkey.bind(
    fromMods, fromKey, nil,
    function()
      if currentBundleID() == appBundleID then
        inputKey(toMods, toKey)
      else
        inputKey(defaultMods, defaultKey)
      end
    end, nil, nil
  )
end

local function bindAppSpecificRemap(appBundleID, fromMods, fromKey, toMods, toKey)
  bindAppSpecificRemapWithDefault(appBundleID, fromMods, fromKey, toMods, toKey, fromMods, fromKey)
end

hs.hotkey.bind({'ctrl'}, 'h', nil, openAppFunc('Utilities/Terminal'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'o', nil, openAppFunc('Nocturn'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'u', nil, openAppFunc('Google Chrome'), nil, nil)

bindAppSpecificRemap('com.google.Chrome', {'cmd'}, 's', {'cmd'}, 'f')

bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'i', {'alt'}, 'i')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 't', {'alt'}, 't')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'w', {'alt'}, 'w')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'j', {'alt'}, 'j')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'k', {'alt'}, 'k')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'f', {'alt'}, 'f')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'b', {'alt'}, 'b')
bindAppSpecificRemapWithDefault('com.apple.Terminal', {'cmd'}, 'o', {'alt'}, 'o', {'cmd', 'shift'}, '[')
bindAppSpecificRemapWithDefault('com.apple.Terminal', {'cmd'}, 'p', {'alt'}, 'p', {'cmd', 'shift'}, ']')
