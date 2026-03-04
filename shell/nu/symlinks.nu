source ~/dev/thing/shell/nu/os.nu

mkdir ~/.config/hypr/
mkdir ~/.config/helix/
mkdir ~/.config/zed/

~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
# ln -sf ~/dev/thing/shell/nu/config.nu "/Users/vladas/Library/Application Support/nushell/config.nu"
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/starship.toml ~/.config/starship.toml
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/helix/config.toml ~/.config/helix/config.toml
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/helix/languages.toml ~/.config/helix/languages.toml
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/ssh_config ~/.ssh/config
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/wezterm.lua ~/.wezterm.lua
~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/ke/commands.yaml ~/.ke/commands.yaml

if $is_linux or $is_mac {
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/settings.json ~/.config/zed/settings.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/keymap.json ~/.config/zed/keymap.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/tasks.json ~/.config/zed/tasks.json
    ~/dev/thing/shell/shorts/slink.py ~/dev/thing/shell/zed/themes ~/.config/zed/themes
}
