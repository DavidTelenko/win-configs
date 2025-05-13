-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local nf = wezterm.nerdfonts

-- Styling
config.color_scheme = "GruvboxDark"

local transparent = "rgba(0%, 0%, 0%, 0%)"

config.colors = {
  background = "black",
  tab_bar = {
    background = transparent,
  },
}

wezterm.on(
  "format-tab-title",
  function(tab, tabs, panes, config, hover, max_width)
    local background = transparent
    local foreground = "#a89984"

    local edge_background = background
    -- ↘️ this is meant to be transparent but it behaves weird
    local edge_foreground = "#000000"

    if tab.is_active then
      background = "#98971a"
      foreground = "#282828"
      edge_foreground = background
    elseif hover then
      background = "#504f0d"
      foreground = "#a89984"
    end

    local title = wezterm.truncate_right(tab.tab_index + 1, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = nf.ple_left_half_circle_thick },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = nf.ple_right_half_circle_thick },
    }
  end
)

-- config.window_padding = {
--   left = "1%",
--   right = "1%",
--   top = "0.5%",
--   bottom = "0.5%",
-- }

-- config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.enable_tab_bar = false
config.font = wezterm.font("RobotoMono Nerd Font Mono")
config.font_size = 20

-- config.window_background_gradient = {
-- 	orientation = { Linear = { angle = -80 } },
-- 	colors = {
-- 		"black",
-- 		"black",
-- 		"black",
-- 		"black",
-- 		"#C33764",
-- 		-- "#302b63",
-- 		-- "#182E48",
-- 	},
-- 	-- preset = "Warm",
-- 	-- "Linear", "Basis" and "CatmullRom" as supported.
-- 	interpolation = "Basis",
-- 	-- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
-- 	blend = "Rgb",
-- 	noise = 30,
-- }

-- Keymaps
config.keys = {
  {
    key = "u",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ScrollByPage(-1),
  },
  {
    key = "d",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ScrollByPage(1),
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ScrollByLine(-1),
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ScrollByLine(1),
  },
  {
    key = "v",
    mods = "CTRL",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
  {
    key = "a",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowTabNavigator,
  },
  {
    key = "Backspace",
    mods = "CTRL",
    action = wezterm.action.SendKey({
      key = "w",
      mods = "CTRL",
    }),
  },
  {
    key = "N",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
      }),
      action = wezterm.action_callback(function(window, pane, line)
        if not line then
          return
        end
        window:perform_action(
          wezterm.action.SwitchToWorkspace({
            name = line,
          }),
          pane
        )
      end),
    }),
  },
  {
    key = "Q",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowLauncherArgs({
      flags = "FUZZY|WORKSPACES",
    }),
  },
}

for i = 0, 8 do
  table.insert(config.keys, {
    key = tostring(i + 1),
    mods = "ALT",
    action = wezterm.action.ActivateTab(i),
  })
end

-- Shells
config.default_prog = { "nu" }
config.default_cwd = "~"

-- and finally, return the configuration to wezterm
return config
