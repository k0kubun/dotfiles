local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_background_opacity = 0.85
config.font = wezterm.font('Monaco', { weight = 'Regular' })
config.font_size = 18.0

config.enable_tab_bar = false

return config
