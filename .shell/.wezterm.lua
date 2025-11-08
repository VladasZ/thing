local wezterm = require 'wezterm'

local config = wezterm.config_builder()


config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font '0xProto Nerd Font'
config.font_size = 12
--config.color_scheme = 'Gruvbox (Gogh)' -- light
config.color_scheme = 'Bamboo'

config.window_close_confirmation = 'NeverPrompt'

-- Spawn a fish shell in login mode
--config.default_prog = { '/usr/local/bin/fish', '-l' }

config.keys = {
	{
		mods = 'CTRL',
		key = 'DownArrow',
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = 'l',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SplitPane {
			direction = 'Right',
			command = { args = { 'lazygit' } },
			--size = { Percent = 50 },
		},
	},
	{
		key = 't',
		mods = 'ALT',
		action = wezterm.action.SplitPane {
			direction = 'Down',
			--command = { args = { 'lazygit' } },
			size = { Percent = 20 },
		},
	},
}


return config