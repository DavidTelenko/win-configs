-- API
local wezterm = require 'wezterm'

-- Plugins-
wezterm.plugin.require 'https://github.com/abidibo/wezterm-sessions'
local tabline =
  wezterm.plugin.require 'https://github.com/michaelbrusegard/tabline.wez'

-- Globals
local config = wezterm.config_builder()
config.automatically_reload_config = true

local nf = wezterm.nerdfonts
local act = wezterm.action

-- Styling

-- config.enable_scroll_bar = true
-- config.tab_max_width = 30
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.enable_tab_bar = true
config.font = wezterm.font 'RobotoMono Nerd Font Mono'
config.font_size = 20
config.window_padding = {
  top = 0,
  bottom = 0,
  -- right = '3px',
}

local transparent_style = false
local gradient_style = false

config.color_scheme = 'GruvboxDark'

if transparent_style then
  config.win32_system_backdrop = 'Acrylic'
  config.macos_window_background_blur = 20
  config.kde_window_background_blur = true
  config.window_background_opacity = 0.8
end

if gradient_style then
  config.window_background_gradient = {
    orientation = { Linear = { angle = -80 } },
    colors = {
      'black',
      'black',
      'black',
      'black',
      '#C33764',
      -- "#302b63",
      -- "#182E48",
    },
    -- preset = "Warm",
    -- "Linear", "Basis" and "CatmullRom" as supported.
    interpolation = 'Basis',
    -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
    blend = 'Rgb',
    noise = 30,
  }
end

local colors = wezterm.color.get_builtin_schemes()[config.color_scheme]
local surface = colors.ansi[1]
local background = '#3c3836' -- TODO: find more portable way
local active_tab = '#a89984'

local normal_color = colors.brights[5]
local copy_color = colors.ansi[3]
local search_color = colors.ansi[7]

config.colors = {
  background = 'black',
  tab_bar = {
    background = background,
  },
}

tabline.setup {
  options = {
    icons_enabled = true,
    theme = config.color_scheme,
    tabs_enabled = true,
    theme_overrides = {
      normal_mode = {
        a = { fg = background, bg = normal_color },
        b = { fg = normal_color, bg = surface },
        c = { fg = colors.foreground, bg = background },
      },
      copy_mode = {
        a = { fg = background, bg = copy_color },
        b = { fg = copy_color, bg = surface },
        c = { fg = colors.foreground, bg = background },
      },
      search_mode = {
        a = { fg = background, bg = search_color },
        b = { fg = search_color, bg = surface },
        c = { fg = colors.foreground, bg = background },
      },
      tab = {
        active = { fg = background, bg = active_tab },
        inactive = { fg = colors.foreground, bg = background },
        inactive_hover = { fg = colors.ansi[6], bg = surface },
      },
    },
    section_separators = {
      -- right = nf.ple_left_half_circle_thick,
      -- left = nf.ple_right_half_circle_thick,
      right = '',
      left = '',
    },
    component_separators = {
      right = '',
      left = '',
    },
    tab_separators = {
      -- right = nf.ple_left_half_circle_thick,
      -- left = nf.ple_right_half_circle_thick,
      right = '',
      left = '',
    },
  },
  sections = {
    tabline_a = {
      {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    tabline_b = { 'workspace' },
    tabline_c = {},
    tab_active = {
      { 'index', padding = 1 },
      -- { 'cwd', padding = { right = 1 } },
    },
    tab_inactive = {
      { 'index', padding = 1 },
      -- { 'process', padding = { right = 1 } },
    },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = {
      { 'datetime', style = '%H:%M - %a %d' },
      -- 'battery',
    },
    tabline_z = { 'domain' },
  },
  extensions = {},
}

-- Keymaps

config.keys = {
  {
    key = 'u',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(-1),
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(1),
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByLine(-1),
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByLine(1),
  },
  {
    key = 'v',
    mods = 'CTRL',
    action = act.PasteFrom 'Clipboard',
  },
  {
    key = 'a',
    mods = 'CTRL|SHIFT',
    action = act.ShowTabNavigator,
  },
  {
    key = 'Backspace',
    mods = 'CTRL',
    action = act.SendKey {
      key = 'w',
      mods = 'CTRL',
    },
  },
  {
    key = 'N',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if not line then
          return
        end
        window:perform_action(
          act.SwitchToWorkspace {
            name = line,
          },
          pane
        )
      end),
    },
  },
  {
    key = 'Q',
    mods = 'CTRL|SHIFT',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = act { EmitEvent = 'save_session' },
  },
  {
    key = 'r',
    mods = 'CTRL|SHIFT',
    action = act { EmitEvent = 'restore_session' },
  },
}

for i = 0, 8 do
  table.insert(config.keys, {
    key = tostring(i + 1),
    mods = 'ALT',
    action = act.ActivateTab(i),
  })
end

-- Autocommands

wezterm.on('gui-startup', function(_)
  local _, pane, window = wezterm.mux.spawn_window {}
  window:gui_window():perform_action(wezterm.action.ToggleFullScreen, pane)
end)

-- Shells
config.default_prog = { 'nu' }

-- Finalize
return config
