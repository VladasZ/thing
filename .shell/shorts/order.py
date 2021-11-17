#!/usr/bin/env python3

import os

os.system("cargo fmt")
os.system("cargo clippy")
os.system("cargo test")
