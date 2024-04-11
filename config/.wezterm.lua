local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_background_opacity = 0.85
config.font_size = 18.0
if wezterm.target_triple:find('darwin') ~= nil then
  config.font = wezterm.font('Monaco', { weight = 'Regular' })
else
  config.font = wezterm.font('Inconsolata')
end

config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
