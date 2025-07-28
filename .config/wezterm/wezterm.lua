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
config.debug_key_events = true
-- keymaps
config.leader = { key = "k", mods="CTRL", timeout_milliseconds = 2000}
config.keys = {
  -- Leader | to split horizontal

  {
    key = ']',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
  {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false }
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 }
 },
 {
  key = 'j',
   mods = 'LEADER',
   action = wezterm.action.AdjustPaneSize { 'Down', 5 }
 },
 {
   key = 'l',
   mods = 'LEADER',
   action = wezterm.action.AdjustPaneSize {'Right', 5}
 },
 {
   key = 'h',
   mods = 'LEADER',
   action = wezterm.action.AdjustPaneSize { 'Left', 5 }
 },
 {
   key = 'q',
   mods = 'LEADER',
   action = wezterm.action.TogglePaneZoomState
 }

}
return config
