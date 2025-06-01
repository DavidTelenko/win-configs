local wezterm = require 'wezterm' --[[@as Wezterm]]
local keybinds = require 'helpers.keybinds'

-- wezterm.plugin.require 'https://github.com/abidibo/wezterm-sessions'
require 'plugins.tabline'

local config = wezterm.config_builder()
local act = wezterm.action

config.default_prog = { 'nu' }
-- config.default_domain = 'WSL:Arch'

config.automatically_reload_config = true

config.tab_max_width = 30
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.enable_tab_bar = true
-- config.window_background_opacity = 0.8
-- config.win32_system_backdrop = 'Acrylic'

config.font = wezterm.font 'RobotoMono Nerd Font Mono'
config.font_size = 20

config.window_padding = {
  top = 0,
  bottom = 0,
}

config.color_scheme = 'GruvboxDark'
config.colors = {
  background = 'black',
  tab_bar = {
    background = require('tabline.config').theme.normal_mode.c.bg,
  },
}

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
    action = keybinds.new_workspace,
  },
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = keybinds.move_tab,
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
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = keybinds.vim_scrollback,
  },
  {
    key = '!',
    mods = 'CTRL|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'default',
      spawn = {
        args = { 'nu' },
      },
    },
  },
  {
    key = '@',
    mods = 'CTRL|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'lxp',
    },
  },
  {
    key = '#',
    mods = 'CTRL|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'arch',
      spawn = {
        domain = {
          DomainName = 'WSL:Arch',
        },
      },
    },
  },
}

for i = 0, 8 do
  table.insert(config.keys, {
    key = tostring(i + 1),
    mods = 'ALT',
    action = act.ActivateTab(i),
  })
end

wezterm.on('gui-startup', function(_)
  local _, pane, window = wezterm.mux.spawn_window {}
  window:gui_window():perform_action(wezterm.action.ToggleFullScreen, pane)
end)

return config
