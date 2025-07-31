local constants = require("constants")
local wezterm = require('wezterm')
local config = wezterm.config_builder()
-- font settings
config.font_size = 18
config.line_height = 1.2
config.font = wezterm.font("MonoLisa")

-- appearance

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Use PowerShell 7 on Windows.
  -- This requires 'pwsh.exe' to be in your system's PATH.
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
end

config.initial_cols = 100
config.initial_rows = 80
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
-- config.window_background_image = constants.bg_image
config.background = {
  {
    source = { Color = 'black' },
    opacity = 0.6,
    width = '100%',
    height = '100%'
  }, 
  {
    source = { File = constants.mascot_image},
    repeat_x = 'NoRepeat',
    vertical_align = 'Bottom',
    repeat_y = 'NoRepeat',
    width = 1000,
    height = 1000,
    opacity = 0.1,
    horizontal_align = 'Right',
    vertical_offset = 90
  }
}
config.macos_window_background_blur = 30 
config.color_scheme = 'ayu'
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.1
}
config.debug_key_events = true
-- keymaps
config.leader = { key = "k", mods="CTRL", timeout_milliseconds = 2000}
config.keys = {

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
 },
 {
   key = 'h',
   mods = 'ALT',
   action = wezterm.action.ActivatePaneDirection('Left')
 },

{
   key = 'j',
   mods = 'ALT',
   action = wezterm.action.ActivatePaneDirection('Down')
 },
 {
   key = 'k',
   mods = 'ALT',
   action = wezterm.action.ActivatePaneDirection('Up')
 },
 {
   key = 'l',
   mods = 'ALT',
   action = wezterm.action.ActivatePaneDirection('Right')
 },
 

}

-- Additional keybindings for pane switching using indexed numbers

for i = 0, 9 do
  table.insert(config.keys, {
    -- The key to press (e.g., "0", "1", "2")
    key = tostring(i),
    
    -- The modifier key
    mods = 'LEADER',
    
    -- The action to perform: activate the pane by its index 'i'
    action = wezterm.action.ActivatePaneByIndex(i),
  })
end

wezterm.on('update-right-status', function(window, pane)
  local num_panes = #window:active_tab():panes()
  local is_zoomed = false

  -- Check if any pane in the current tab is zoomed
  for _, p in ipairs(window:active_tab():panes()) do
    if p.is_zoomed then
      is_zoomed = true
      break
    end
  end

  -- Display the indicator only if a pane is zoomed and there are multiple panes
  if is_zoomed and num_panes > 1 then
    window:set_right_status(wezterm.format {
      -- Add a little bit of styling to make it stand out
      { Background = { Color = '#ffb86c' } }, -- A nice orange color
      { Foreground = { Color = '#282a36' } }, -- A contrasting dark color
      { Text = string.format(' 🔍 Zoomed (%d panes) ', num_panes) },
    })
  else
    -- Clear the status when not zoomed
    window:set_right_status('')
  end
end)

return config
