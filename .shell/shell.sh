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
alias hx=helix

alias d='sudo docker'

alias tf=terraform
alias l=lazygit

alias al='hx ~/dev/thing/.shell/shell.sh'
alias hy='hx ~/dev/thing/.shell/hyprland.conf'

alias install_mac=~/dev/thing/.shell/install_mac.sh
alias install_lin=~/dev/thing/.shell/install_lin.sh

target_link=~/.config/zed

if [ ! -e "$target_link" ]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        source_path=~/dev/thing/.shell/zed
    elif [[ "$(uname)" == "Linux" ]]; then
        source_path=~/dev/thing/.shell/zed_lin
    else
        echo "Unsupported operating system"
        exit 1
    fi

    ln -sf $source_path $target_link
    echo "Zed link: OK"
fi

function clone {
    cargo run --manifest-path ~/dev/thing/Cargo.toml -p clone --release --target-dir ~/dev/thing/target -- "$@"
}

function push {
    cargo run --manifest-path ~/dev/thing/Cargo.toml -p push --release --target-dir ~/dev/thing/target -- "$@"
}

function st {
    cargo run --manifest-path ~/dev/thing/Cargo.toml -p st --release --target-dir ~/dev/thing/target -- "$@"
}

function reset_db {
    git checkout HEAD -- ./db/structure.sql
    bin/rails db:reset RAILS_ENV=test
    bin/rails db:migrate RAILS_ENV=test
}
