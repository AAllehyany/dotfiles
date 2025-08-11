local constants = require("constants")
local wezterm = require('wezterm')
local config = wezterm.config_builder()
-- font settings
config.font_size = 18
config.line_height = 1.2
config.font = wezterm.font("MonoLisa")

config.color_schemes = {
  Yin = {
    background = '#000000',
    foreground = '#ffffff',

    cursor_bg = '#ffffff',
    cursor_fg = '#000000',
    cursor_border = '#ffffff',

    selection_bg = '#262626',
    selection_fg = '#ffffff',

    ansi = {
      '#000000',
      '#ff0000',
      '#00ff00',
      '#ffff00',
      '#0000ff',
      '#ff00ff',
      '#00ffff',
      '#ffffff',
    },

    brights = {
      '#808080',
      '#ff0000',
      '#00ff00',
      '#ffff00',
      '#0000ff',
      '#ff00ff',
      '#00ffff',
      '#ffffff',
    },
  },
}
-- appearance

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Use PowerShell 7 on Windows.
  -- This requires 'pwsh.exe' to be in your system's PATH.
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.default_domain = 'WSL:Ubuntu-24.04'
end

config.initial_cols = 100
config.initial_rows = 80
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
-- config.window_background_image = constants.bg_image
-- This function calculates and applies the correctly-sized background
local function set_dynamic_background(window)
  local aspect_ratio = 1000 / 1362

  local height_scale = 0.6

  local offset_scale = 0.02

  -- Get the pixel dimensions of the current window
  local dims = window:get_dimensions()
  if not dims.pixel_height or dims.pixel_height == 0 then
    return
  end
  
  local image_height_px = dims.pixel_height * height_scale
  local image_width_px = image_height_px * aspect_ratio

  local vertical_offset_px = dims.pixel_height * offset_scale
  local horizontal_offset_px = dims.pixel_width * offset_scale

  window:set_config_overrides({
    background = {
      {
        source = { Color = '#0a0a0a' },
        opacity = 0.4,
        width = '100%',
        height = '100%'
      },
      {
        source = { File = constants.saudi_mascot_path },
        opacity = 0.1,
        width = image_width_px,
        height = image_height_px,
        vertical_offset = vertical_offset_px,
        horizontal_offset = horizontal_offset_px,
        repeat_x = 'NoRepeat',
        repeat_y = 'NoRepeat',
        horizontal_align = 'Right',
        vertical_align = 'Bottom',
      },
    },
  })
end
-- config.background = {
--   {
--     source = { Color = 'black' },
--     opacity = 0.6,
--     width = '100%',
--     height = '100%'
--   }, 
--   {
--     source = { File = constants.saudi_mascot_path},
--     repeat_x = 'NoRepeat',
--     vertical_align = 'Bottom',
--     repeat_y = 'NoRepeat',
--     width = "10cell",
--     height = "cell",
--     opacity = 0.05,
--     horizontal_align = 'Right',
--   }
-- }
config.macos_window_background_blur = 30 
config.color_scheme = 'Yin'
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.1
}
wezterm.on('window-resized', function(window, pane)
  set_dynamic_background(window)
end)
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
