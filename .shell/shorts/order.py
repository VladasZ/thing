#!/usr/bin/env python3

import os
import subprocess


def run(command):
    print("Run: " + command)
    subprocess.run(command, shell=True, check=True)


run("cargo install cargo-machete")
run("cargo install typos-cli")
run("cargo install taplo-cli")

run("taplo fmt")
run("cargo +nightly fmt --all")
run("typos")
run("cargo machete")
run("make lint")
run("cargo build --all")
run("make test")

print("order: Ok")
