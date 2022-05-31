#!/usr/bin/env python3

import os

os.system("cargo +nightly fmt --all")
os.system("cargo clippy")
os.system("cargo test")
os.system("cargo build")
