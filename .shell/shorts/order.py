#!/usr/bin/env python3

import os

os.system("cargo +nightly fmt --all")
os.system("cargo clippy --all")
os.system("cargo test --all")
os.system("cargo build --all")
os.system("typos")
os.system("cargo machete")
