local wezterm = require 'wezterm'
local dev = wezterm.plugin.require("https://github.com/ChrisGVE/dev.wezterm")


local is_mac = (package.config:sub(1,1) == '/' and io.popen("uname"):read("*l") == "Darwin")

local config = wezterm.config_builder()


config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font '0xProto Nerd Font'

if is_mac then
	config.font_size = 16
else
	config.font_size = 14
end

--config.color_scheme = 'Gruvbox (Gogh)' -- light
config.color_scheme = 'Bamboo'

config.window_close_confirmation = 'NeverPrompt'

--config.window_decorations = "RESIZE"


if is_mac then
	config.default_prog = { '/opt/homebrew/bin/nu' }
end

--https://github.com/quantonganh/quickselect.wezterm

local toggle_terminal = wezterm.plugin.require("https://github.com/zsh-sage/toggle_terminal.wez")

toggle_terminal.apply_to_config(config, {
	key = "RightArrow", -- Key for the toggle action
	mods = "CMD", -- Modifier keys for the toggle action
	direction = "Down", -- Direction to split the pane
	--size = { Percent = 20 }, -- Size of the split pane
	--change_invoker_id_everytime = false, -- Change invoker pane on every toggle
	--zoom = {
	--	auto_zoom_toggle_terminal = false, -- Automatically zoom toggle terminal pane
	--	auto_zoom_invoker_pane = true, -- Automatically zoom invoker pane
	--	remember_zoomed = true, -- Automatically re-zoom the toggle pane if it was zoomed before switching away
	--}
})

config.keys = {
	{
		mods = 'CMD',
		key = 'DownArrow',
		action = wezterm.action.SplitPane {
			direction = 'Down',
			--command = { args = { 'top' } },
			size = { Percent = 20 },
		},
	},
	--https://github.com/wezterm/wezterm/issues/606#issuecomment-1238029208
	{
		key = 'c',
		mods = 'CTRL',
		action = wezterm.action_callback(function(window, pane)
			selection_text = window:get_selection_text_for_pane(pane)
			is_selection_active = string.len(selection_text) ~= 0
			if is_selection_active then
				window:perform_action(wezterm.action.CopyTo('ClipboardAndPrimarySelection'), pane)
			else
				window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
			end
		end),
	},
	{
		mods = 'CTRL',
		key = 'v',
		action = wezterm.action.PasteFrom 'Clipboard',
	},
	--{
	--	key = 'l',
	--	mods = 'CTRL|SHIFT',
	--	action = wezterm.action.SplitPane {
	--		direction = 'Right',
	--		command = { args = { 'lazygit' } },
	--		--size = { Percent = 50 },
	--	},
	--},
	{
		key = 't',
		mods = 'ALT',
		action = wezterm.action.SplitPane {
			direction = 'Down',
			--command = { args = { 'lazygit' } },
			size = { Percent = 20 },
		},
	},
	{
		key = 'l',
		mods = 'ALT',
		action = wezterm.action.SplitPane {
			direction = 'Right',
		  	command = { args = { 'lazygit' } },
			size = { Percent = 20 },
		},
	}
}


return config
