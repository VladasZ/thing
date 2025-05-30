if [[ $- == *i* ]]; then
    echo Helloy
fi

PROMPT='v %1~ %# '

export VAGRANT_DEFAULT_PROVIDER=utm

ln -sf ~/dev/thing/.shell/.alacritty.toml ~/.alacritty.toml

mkdir -p ~/dev/thing/.shell/_shorts

ln -sf ~/dev/thing/.shell/shorts/order.py ~/dev/thing/.shell/_shorts/order
ln -sf ~/dev/thing/.shell/shorts/publish.py ~/dev/thing/.shell/_shorts/publish
ln -sf ~/dev/thing/.shell/shorts/slink.py ~/dev/thing/.shell/_shorts/slink
ln -sf ~/dev/thing/.shell/shorts/tag.py ~/dev/thing/.shell/_shorts/tag

chmod +x ~/dev/thing/.shell/_shorts/order

export PATH=$PATH:~/dev/thing/.shell/shorts
export PATH=$PATH:~/dev/thing/.shell/_shorts
export PATH=$PATH:~/dev/deps/qw/target/debug

alias z=zellij
alias dotf='terraform apply -auto-approve'
alias untf='terraform destroy -auto-approve'

alias te='cd ~/dev/test-engine/'
alias th='cd ~/dev/thing'
alias be='cd ~/dev/sweatcoin/sweatcoin-backend'

alias d='sudo docker'

alias tf=terraform
alias l=lazygit
alias k=kubectl
alias a=ansible
alias p=ansible-playbook
alias m=micro

function clone {
    binary_path="$HOME/dev/thing/target/release/clone"

    if [ -f "$binary_path" ]; then
        "$binary_path" "$@"
    else
        cargo run --manifest-path "$HOME/dev/thing/Cargo.toml" -p clone --release --target-dir "$HOME/dev/thing/target" -- "$@"
    fi
}

function push {
    binary_path="$HOME/dev/thing/target/release/push"

    if [ -f "$binary_path" ]; then
        "$binary_path" "$@"
    else
        cargo run --manifest-path "$HOME/dev/thing/Cargo.toml" -p push --release --target-dir "$HOME/dev/thing/target" -- "$@"
    fi
}

function st {
    binary_path="$HOME/dev/thing/target/release/st"

    if [ -f "$binary_path" ]; then
        "$binary_path" "$@"
    else
        cargo run --manifest-path "$HOME/dev/thing/Cargo.toml" -p st --release --target-dir "$HOME/dev/thing/target" -- "$@"
    fi
}

function pull {
    st
    st --pull
}

function close {
    pkill -x Gitnuro
    pkill -x Obsidian
    pkill -x RubyMine
    osascript -e 'quit app "Firefox"'
    osascript -e 'quit app "Telegram"'
    osascript -e 'quit app "RustRover"'
    osascript -e 'quit app "Slack"'
    osascript -e 'quit app "Discord"'
    osascript -e 'quit app "Finder"'
    osascript -e 'quit app "System Settings"'
    osascript -e 'quit app "JetBrains Toolbox"'
    osascript -e 'quit app "Alacritty"'
}

function allow() {
  local target_path="$1"

  if [[ -z "$target_path" ]]; then
    echo "Usage: unquarantine_app /full/path/to/target"
    return 1
  fi

  if [[ ! -e "$target_path" ]]; then
    echo "Error: $target_path does not exist."
    return 1
  fi

  sudo xattr -rd com.apple.quarantine "$target_path"
  echo "Unquarantined: $target_path"
}
