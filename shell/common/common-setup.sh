#!/bin/bash

set -euxo pipefail

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

sudo npm config set fund false --location=global

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

git config --global user.email "146100@gmail.com"
git config --global user.name "Vladas Zakrevskis"

if [[ "$(uname)" == "Darwin" ]]; then
    git config --global gpg.format ssh
    git config --global user.signingkey ~/.ssh/id_ed25519.pub
    git config --global commit.gpgsign true
fi
