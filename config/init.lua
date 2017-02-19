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

local function currentApp()
  local focused = hs.window.focusedWindow()
  if focused then
    return hs.window.application(focused)
  end
end

local function currentBundleID()
  local app = currentApp()
  if app then
    return hs.application.bundleID(app)
  end
end

local function inputKey(modifiers, key)
  local args = {}
  local app = currentApp()
  if app then
    args = {app}
  end
  hs.eventtap.event.newKeyEvent(modifiers, key, true):post(args)
  hs.timer.usleep(1000)
  hs.eventtap.event.newKeyEvent(modifiers, key, false):post(args)
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

-- Application Launcher
hs.hotkey.bind({'ctrl'}, 'h', nil, openAppFunc('Utilities/Terminal'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'o', nil, openAppFunc('Nocturn'), nil, nil)
hs.hotkey.bind({'ctrl'}, 'u', nil, openAppFunc('Google Chrome'), nil, nil)

-- Chrome
bindAppSpecificRemap('com.google.Chrome', {'cmd'}, 's', {'cmd'}, 'f')

-- Terminal
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'i', {'alt'}, 'i')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 't', {'alt'}, 't')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'w', {'alt'}, 'w')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'f', {'alt'}, 'f')
bindAppSpecificRemap('com.apple.Terminal', {'cmd'}, 'b', {'alt'}, 'b')
bindAppSpecificRemapWithDefault('com.apple.Terminal', {'cmd'}, 'o', {'alt'}, 'o', {'cmd', 'shift'}, '[')
bindAppSpecificRemapWithDefault('com.apple.Terminal', {'cmd'}, 'p', {'alt'}, 'p', {'cmd', 'shift'}, ']')

-- Slack
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'cmd'}, 'n', {'cmd'}, 'k')
bindAppSpecificRemapWithDefault('com.tinyspeck.slackmacgap', {'cmd'}, 'j', {'alt'}, 'down', {'alt'}, 'j')
bindAppSpecificRemapWithDefault('com.tinyspeck.slackmacgap', {'cmd'}, 'k', {'alt'}, 'up', {'alt'}, 'k')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '1', {'cmd'}, '1')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '2', {'cmd'}, '2')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '3', {'cmd'}, '3')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '4', {'cmd'}, '4')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '5', {'cmd'}, '5')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '6', {'cmd'}, '6')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '7', {'cmd'}, '7')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '8', {'cmd'}, '8')
bindAppSpecificRemap('com.tinyspeck.slackmacgap', {'ctrl'}, '9', {'cmd'}, '9')
