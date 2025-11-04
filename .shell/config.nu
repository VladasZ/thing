# $nu.config-path

use std/util "path add"

path add ~/.cargo/bin
path add /opt/homebrew/bin

let is_windows = $nu.os-info.name == 'windows'
let is_mac = $nu.os-info.name == 'macos'
let is_linux = $nu.os-info.name == 'linux'
let is_arch: bool = $is_linux and (open /etc/os-release | str join "\n" | str contains "ID=arch")


if $is_linux {
    $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent.socket"
}

$env.config.show_banner = false
$env.VAGRANT_DEFAULT_PROVIDER = "utm"

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")


def symlink [target link] {
    if $is_windows {
        ^cmd /c mklink $link $target | ignore
    } else {
        ^ln -sf $target $link
    }
}

# if not $is_windows {

#     symlink ~/dev/thing/.shell/.alacritty.toml ~/.alacritty.toml
#     symlink ~/dev/thing/.shell/starship.toml ~/.config/starship.toml

#     mkdir ~/dev/thing/.shell/_shorts

#     symlink ~/dev/thing/.shell/shorts/order.py   ~/dev/thing/.shell/_shorts/order
#     symlink ~/dev/thing/.shell/shorts/publish.py ~/dev/thing/.shell/_shorts/publish
#     symlink ~/dev/thing/.shell/shorts/slink.py   ~/dev/thing/.shell/_shorts/slink
#     symlink ~/dev/thing/.shell/shorts/tag.py     ~/dev/thing/.shell/_shorts/tag

#     chmod +x ~/dev/thing/.shell/_shorts/order
# }

$env.PATH = ($env.PATH | append [
    "~/dev/thing/.shell/shorts"
    "~/dev/thing/.shell/_shorts"
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
alias hx = helix
alias e = exit
alias q = exit
alias t = btop --force-utf
alias ping = gping
alias matrix = unimatrix -s 96
alias al = micro ~/.config/hypr/hyprland.conf
alias hosts = sudo micro /etc/hosts


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
        "RubyMine"
        "WebStorm"
        "Docker Desktop"
    ]
    
    for app in $apps {
        osascript -e $'quit app "($app)"' | ignore
    }
    
    sleep 2sec
    osascript -e 'quit app "Alacritty"' | ignore
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
