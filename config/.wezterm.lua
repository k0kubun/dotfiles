local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

local is_linux = wezterm.target_triple:find('linux') ~= nil
local is_macos = wezterm.target_triple:find('darwin') ~= nil
local is_windows = wezterm.target_triple:find('windows') ~= nil

-- Styles
config.window_background_opacity = 0.85
if is_macos then
  config.font_size = 20.0
  config.font = wezterm.font_with_fallback { 'Monaco', 'Hiragino Sans' }
elseif is_linux then
  config.font_size = 16.0
  config.font = wezterm.font_with_fallback { 'Monaco', 'Noto Sans CJK JP' }
elseif is_windows then
  config.font_size = 16.0
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
if is_linux then
  config.keys = {
    { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard' },
  }
end

-- WSL
if is_windows then
  config.default_domain = 'WSL:Ubuntu'
end

return config
