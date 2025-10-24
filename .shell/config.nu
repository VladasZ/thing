use std/util "path add"

path add ~/.cargo/bin
path add /opt/homebrew/bin

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.config.show_banner = false

$env.VAGRANT_DEFAULT_PROVIDER = "utm"

ln -sf ~/dev/thing/.shell/.alacritty.toml ~/.alacritty.toml
ln -sf ~/dev/thing/.shell/starship.toml ~/.config/starship.toml

mkdir ~/dev/thing/.shell/_shorts

ln -sf ~/dev/thing/.shell/shorts/order.py ~/dev/thing/.shell/_shorts/order
ln -sf ~/dev/thing/.shell/shorts/publish.py ~/dev/thing/.shell/_shorts/publish
ln -sf ~/dev/thing/.shell/shorts/slink.py ~/dev/thing/.shell/_shorts/slink
ln -sf ~/dev/thing/.shell/shorts/tag.py ~/dev/thing/.shell/_shorts/tag

chmod +x ~/dev/thing/.shell/_shorts/order

# PATH setup
$env.PATH = ($env.PATH | append [
    "~/dev/thing/.shell/shorts"
    "~/dev/thing/.shell/_shorts"
    "~/dev/deps/qw/target/debug"
])

# Aliases
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

def clone [...args] {
    let binary_path = $"($env.HOME)/dev/thing/target/release/clone"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($env.HOME)/dev/thing/Cargo.toml" -p clone --release --target-dir $"($env.HOME)/dev/thing/target" -- ...$args
    }
}

def push [...args] {
    let binary_path = $"($env.HOME)/dev/thing/target/release/push"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($env.HOME)/dev/thing/Cargo.toml" -p push --release --target-dir $"($env.HOME)/dev/thing/target" -- ...$args
    }
}

def st [...args] {
    let binary_path = $"($env.HOME)/dev/thing/target/release/st"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($env.HOME)/dev/thing/Cargo.toml" -p st --release --target-dir $"($env.HOME)/dev/thing/target" -- ...$args
    }
}

def pull [] {
    st
    st "--pull"
}

# Close function
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
    
    if (sys host | get name) == "Darwin" {
        brew update
        brew upgrade
    }
    
    if (which apt | is-not-empty) {
        sudo apt update
        sudo apt upgrade -y
    }
    
    pull
}

def bb [] {
    st
    if $env.LAST_EXIT_CODE != 0 {
        return
    }
    
    if (sys host | get name) == "Darwin" {
        close
    }
}
