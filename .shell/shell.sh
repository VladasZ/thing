echo Helloy

PROMPT='v %1~ %# '

ln -sf ~/dev/thing/.shell/.alacritty.toml ~/.alacritty.toml

mkdir -p ~/dev/thing/.shell/_shorts

ln -sf ~/dev/thing/.shell/shorts/order.py ~/dev/thing/.shell/_shorts/order

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

alias al='hx ~/dev/thing/.shell/shell.sh'
alias hy='hx ~/dev/thing/.shell/hyprland.conf'

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
