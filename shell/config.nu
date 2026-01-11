# $nu.config-path

use std/util "path add"

let is_windows = $nu.os-info.name == 'windows'
let is_mac = $nu.os-info.name == 'macos'
let is_linux = $nu.os-info.name == 'linux'
let is_arch: bool = $is_linux and (open /etc/os-release | str join "\n" | str contains "ID=arch")


path add ~/.cargo/bin
path add ~/.deno/bin/

if $is_mac {
    path add /opt/homebrew/bin
    path add /Library/Developer/CommandLineTools/usr/bin/
}

if $is_linux {
    $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent.socket"
}

$env.config.show_banner = false
$env.VAGRANT_DEFAULT_PROVIDER = "utm"

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

mkdir ~/.config/hypr/
mkdir ~/.config/helix/

ln -sf ~/dev/thing/shell/hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
# ln -sf ~/dev/thing/shell/config.nu "/Users/vladas/Library/Application Support/nushell/config.nu"
ln -sf ~/dev/thing/shell/starship.toml ~/.config/starship.toml
ln -sf ~/dev/thing/shell/helix/config.toml ~/.config/helix/config.toml
ln -sf ~/dev/thing/shell/helix/languages.toml ~/.config/helix/languages.toml
ln -sf ~/dev/thing/shell/ssh_config ~/.ssh/config
ln -sf ~/dev/thing/shell/wezterm.lua ~/.wezterm.lua

$env.PATH = ($env.PATH | append [
    "~/dev/thing/shell/shorts"
    "~/dev/thing/shell/_shorts"
    "~/dev/deps/qw/target/debug"
    "/Applications/Docker.app/Contents/Resources/bin"
])

alias z = zellij
alias dotf = terraform apply -auto-approve
alias untf = terraform destroy -auto-approve
alias te = cd ~/dev/test-engine/
alias th = cd ~/dev/thing
alias d = sudo docker
alias tf = terraform
alias l = lazygit
alias k = kubectl
alias a = ansible
alias p = ansible-playbook
alias c = clear
alias h = cd ~/
alias q = exit
alias t = btop --force-utf
alias ping = gping
alias al = micro ~/.config/hypr/hyprland.conf
alias hosts = sudo micro /etc/hosts
alias order = ~/dev/thing/shell/shorts/order.py
alias o = order
alias cba = cargo build --all
alias cta = cargo test --all

if not $is_mac {
    alias hx = helix
}



def install [app: string] {
    if $is_arch {
        sudo pacman -S $app --noconfirm
    } else if $is_mac {
        brew install $app
    } else {
        panic "not implemented"
    }
}

# sudo scutil --set HostName new-name
# sudo scutil --set LocalHostName new-name
# sudo scutil --set ComputerName new-name


def clone [...args] {
    let binary_path = $"($nu.home-path)/dev/thing/target/release/clone"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($nu.home-path)/dev/thing/Cargo.toml" -p clone --release --target-dir $"($nu.home-path)/dev/thing/target" -- ...$args
    }
}

def push [...args] {
    let binary_path = $"($nu.home-path)/dev/thing/target/release/push"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($nu.home-path)/dev/thing/Cargo.toml" -p push --release --target-dir $"($nu.home-path)/dev/thing/target" -- ...$args
    }
}

def st [...args] {
    let binary_path = $"($nu.home-path)/dev/thing/target/release/st"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($nu.home-path)/dev/thing/Cargo.toml" -p st --release --target-dir $"($nu.home-path)/dev/thing/target" -- ...$args
    }
}

def pull [] {
    st
    st "--pull"
}

def close [] {
    pkill -x Gitnuro | ignore
    pkill -x Obsidian | ignore
    pkill -x RubyMine | ignore
    pkill -x BambuStudio | ignore

    let apps = [
        "Firefox"
        "Gitkraken"
        "Telegram"
        "Slack"
        "Steam"
        "Discord"
        "Messenger"
        "Calendar"
        "Lens"
        "Finder"
        "Xcode"
        "Transmission"
        "Deezer"
        "System Settings"
        "JetBrains Toolbox"
        "Visual Studio Code"
        "zoom.us"
        "RustRover"
        "Clion"
        "Safari"
        "RubyMine"
        "WebStorm"
        "Docker Desktop"
    ]
    
    for app in $apps {
        osascript -e $'quit app "($app)"' | ignore
    }
    
    sleep 2sec
    osascript -e 'quit app "Alacritty"' | ignore
    pkill -x WezTerm | ignore

    exit
}

def allow [target_path: string] {
    if not ($target_path | path exists) {
        print $"Error: ($target_path) does not exist."
        return
    }
    
    sudo xattr -rd com.apple.quarantine $target_path
    print $"Unquarantined: ($target_path)"
}

def hi [] {
    cargo install cargo-update
    cargo install-update -a
    rustup update
    
    if $is_mac {
        brew update
        brew upgrade
    }

    if $is_arch {
        sudo pacman -Syu --noconfirm
        yay -Syu --noconfirm
        yay -Yc --noconfirm
    }
    
    pull
}

def bb [] {
    st
    if $env.LAST_EXIT_CODE != 0 {
        return
    }
    
    if $is_mac {
        close
    }
}

def rmlhost [] {
    let lines = (open ~/.ssh/known_hosts | lines)
    let count = ($lines | length)
    let removed = ($lines | skip ($count - 2))

    print "Last two lines:"
    print $removed

    $lines | drop 1 | save -f ~/.ssh/known_hosts
}

def publish [package?: string] {
    if ($package | is-not-empty) {
        print $"Publishing package: ($package)"
        cargo publish -p $package --allow-dirty
    } else {
        print "Publishing current package."
        cargo publish --allow-dirty
    }
}

def nuconf [] {
    echo $nu.default-config-dir
}

# Rust:
if $is_mac {
    # source $"($nu.home-path)/.cargo/env.nu"
    # if ios: sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
    $env.SDKROOT = (xcrun --show-sdk-path)
    $env.CFLAGS = $"-isysroot ($env.SDKROOT)"
}
