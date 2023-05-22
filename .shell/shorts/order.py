#!/usr/bin/env python3

import os

os.system("cargo install cargo-machete")
os.system("cargo install typos-cli")

os.system("cargo +nightly fmt --all")
os.system("cargo test --all")
os.system("cargo build --all")
os.system("cargo clippy --all -- -A clippy::mismatched_target_os -A clippy::module_inception")
os.system("typos")
# os.system("cargo machete")
