source ~/dev/thing/shell/nu/os.nu

def install [app: string] {
    if $is_arch {
        sudo pacman -S $app --noconfirm
    } else if $is_mac {
        brew install $app
    } else if $is_windows {
        scoop install $app
    } else {
        panic "not implemented"
    }
}

def --env set-hostname [name: string] {
    let targets = ["ComputerName", "LocalHostName", "HostName"]

    for target in $targets {
        print $"Setting ($target) to ($name)..."
        sudo scutil --set $target $name
    }

    print "Flushing DNS cache..."
    sudo killall -HUP mDNSResponder

    print $"Hostname successfully changed to: ($name)"
}

def clone [...args] {
    let binary_path = $"($nu.home-dir)/dev/thing/target/release/clone"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($nu.home-dir)/dev/thing/Cargo.toml" -p clone --release --target-dir $"($nu.home-dir)/dev/thing/target" -- ...$args
    }
}

def push [...args] {
    let binary_path = $"($nu.home-dir)/dev/thing/target/release/push"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($nu.home-dir)/dev/thing/Cargo.toml" -p push --release --target-dir $"($nu.home-dir)/dev/thing/target" -- ...$args
    }
}

def st [...args] {
    let binary_path = $"($nu.home-dir)/dev/thing/target/release/st"
    if ($binary_path | path exists) {
        ^$binary_path ...$args
    } else {
        cargo run --manifest-path $"($nu.home-dir)/dev/thing/Cargo.toml" -p st --release --target-dir $"($nu.home-dir)/dev/thing/target" -- ...$args
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
        "Zed"
        "Notes"
        "DBeaver"
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

    if $is_debian {
        sudo apt update
        sudo apt upgrade -y
    }

    if $is_windows {
        scoop update -a
    }

    pull
    refresh-projects
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

def --env nvm [...args: string] {
    let nvm_sh = "/opt/homebrew/opt/nvm/nvm.sh"
    let cmd = ($args | str join " ")

    if ($args | first? | default "" | $in == "use") {
        let version = (bash -c $"source ($nvm_sh) && nvm ($cmd) && node --version" | str trim)
        let node_bin = ($env.NVM_DIR | path join $"versions/node/($version)/bin")
        if ($node_bin | path exists) {
            $env.PATH = ($env.PATH | prepend $node_bin)
            print $"Now using Node ($version)"
        }
    } else {
        bash -c $"source ($nvm_sh) && nvm ($cmd)"
    }
}

def up [] {
    let cwd = (pwd)
    let left_pane = $env.WEZTERM_PANE
    let right_pane = (wezterm cli split-pane --right --pane-id $left_pane --cwd $cwd | str trim)
    wezterm cli send-text --pane-id $left_pane $"cd backend; ke up\n"
    wezterm cli send-text --pane-id $right_pane $"cd frontend; ke up\n"
}

def ports [] {
    lsof -i -P -n
    | lines
    | skip 1
    | where { |line| $line | str contains "(LISTEN)" }
    | each { |line|
        let parts = ($line | split row -r '\s+')
        let address = ($parts | get 8)
        let port = ($address | split row ":" | last | into int)
        {app: ($parts | get 0), pid: ($parts | get 1 | into int), port: $port, address: $address}
    }
    | sort-by port
}

def clog [port: int] {
    print $"Clogging port ($port)... Press Ctrl+C to release."
    python3 -c "
import socket, sys
port = int(sys.argv[1])
s = socket.socket()
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(('', port))
s.listen(1)
while True:
    try:
        conn, _ = s.accept()
        conn.close()
    except KeyboardInterrupt:
        break
s.close()
" ($port | into string)
}

def nt [] {
    wezterm cli spawn | ignore
}

def clean [] {
    let dev = ($nu.home-dir | path join "dev")
    let roots = glob $"($dev)/**/Cargo.toml" --depth 10
        | each { |f| $f | path dirname }
        | where { |dir|
            mut ancestor = ($dir | path dirname)
            mut is_root = true
            while $ancestor != $dev {
                if ($ancestor | path join "Cargo.toml" | path exists) {
                    $is_root = false
                    break
                }
                $ancestor = ($ancestor | path dirname)
            }
            $is_root
        }

    $roots | each { |dir|
        print $"Cleaning ($dir)..."
        cargo clean --manifest-path ($dir | path join "Cargo.toml")
    } | ignore

    if $is_mac {
        print "Cleaning Simulator dyld cache..."
        sudo rm -rf /Library/Developer/CoreSimulator/Caches/dyld
    }

    let answer = (input "Clean Docker? [y/n] ")
    if $answer == "y" {
        print "Cleaning Docker..."
        let containers = (docker ps -aq | lines | where { |l| $l != "" })
        if ($containers | is-not-empty) {
            docker rm -f ...$containers | ignore
        }
        docker system prune -af --volumes | ignore
    }
}

def drk [] {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
}

def lit [] {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
}

def reload [] {
    exec nu
}

def cm [...args] {
     with-env { CLAUDE_CONFIG_DIR: ([$env.HOME, ".claude-my"] | path join) } { claude ...$args }
}

def cz [...args] {
     with-env { CLAUDE_CONFIG_DIR: ([$env.HOME, ".claude-z"] | path join) } { claude ...$args }
}

def qw-local [...args] {
    cargo run --manifest-path /Users/vladas/dev/deps/qw/Cargo.toml -- ...$args
}

def g [...args] {
    ^g ...$args
}
