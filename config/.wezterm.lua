local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Styles
config.window_background_opacity = 0.85
config.font_size = 20.0
if wezterm.target_triple:find('darwin') ~= nil then
  config.font = wezterm.font_with_fallback { 'Monaco', 'Hiragino Sans' }
else
  config.font = wezterm.font_with_fallback { 'Inconsolata', 'Noto Sans CJK JP' }
end

-- Disable annoying features
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.audible_bell = 'Disabled'

-- Clipboard
if wezterm.target_triple:find('linux') ~= nil then
  config.keys = {
    { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard' },
  }
end

return config
