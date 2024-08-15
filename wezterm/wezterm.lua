-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Styling
config.color_scheme = "GruvboxDark"

config.colors = {
	background = "black",
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.font = wezterm.font("RobotoMono Nerd Font Mono")
config.font_size = 16

config.window_background_gradient = {
	orientation = { Linear = { angle = -90 } },
	colors = {
		"black",
		"black",
		"black",
		"#C33764",
		-- "#302b63",
		-- "#182E48",
	},
	-- preset = "Warm",
	-- "Linear", "Basis" and "CatmullRom" as supported.
	interpolation = "Basis",
	-- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
	blend = "Rgb",
	noise = 72,
}

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
