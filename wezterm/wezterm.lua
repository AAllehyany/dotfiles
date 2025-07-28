local constants = require("constants")
local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- font settings
config.font_size = 16
config.line_height = 1.2
config.font = wezterm.font("MonoLisa")

-- appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_image = constants.bg_image
config.color_scheme = 'ayu'
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.1
}
return config
