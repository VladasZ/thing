source ~/dev/thing/shell/nu/os.nu


if $is_arch {
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
}
# ln -sf ~/dev/thing/shell/nu/config.nu "/Users/vladas/Library/Application Support/nushell/config.nu"
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/starship.toml ~/.config/starship.toml
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/helix/config.toml ~/.config/helix/config.toml
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/helix/languages.toml ~/.config/helix/languages.toml
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/wezterm.lua ~/.wezterm.lua
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/ke/commands.yaml ~/.ke/commands.yaml

if $is_windows {
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/nu/config.nu C:\Users\vladas\AppData\Roaming\nushell\config.nu
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/lazygit/config.yml ~/AppData\Roaming\lazygit\config.yml
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/settings.json ~/AppData\Roaming\Zed\settings.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/keymap.json ~/AppData\Roaming\Zed\keymap.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/tasks.json ~/AppData\Roaming\Zed\tasks.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/themes ~/AppData\Roaming\Zed\themes
}

if $is_linux {
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/lazygit/config.yml ~/.config/lazygit/config.yml
}

if $is_mac {
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/lazygit/config.yml "~/Library/Application Support/lazygit/config.yml"
}

if $is_linux or $is_mac {
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/settings.json ~/.config/zed/settings.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/keymap.json ~/.config/zed/keymap.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/tasks.json ~/.config/zed/tasks.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/themes ~/.config/zed/themes
}
