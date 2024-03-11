#!/usr/bin/env python3

import os

os.system("cargo +nightly fmt")
os.system("cargo clippy")
os.system("cargo test")
os.system("cargo build")
os.system("python3 build.py android")
os.system("python3 build.py ios")
