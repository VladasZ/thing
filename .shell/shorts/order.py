#!/usr/bin/env python3

import subprocess


def run(command):
    print("Run: " + command)
    subprocess.run(command, shell=True, check=True)


def has_make_target(target_name):
    try:
        # Run `make -qp` and parse the output
        result = subprocess.run(
            "make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\\/\t=]*:([^=]|$)/ {print $1}' | sort -u",
            shell=True,
            capture_output=True,
            text=True
        )

        if result.returncode != 0:
            print("Error running make:", result.stderr)
            return False

        targets = result.stdout.splitlines()
        return target_name in targets

    except Exception as e:
        print("Error:", e)
        return False


run("cargo install cargo-machete --locked")
run("cargo install typos-cli --locked")
run("cargo install taplo-cli --locked")

run("taplo fmt")
run("cargo +nightly fmt --all")
run("typos")
run("cargo machete")

if has_make_target("lint"):
    run("make lint")

run("cargo build --all")

if has_make_target("test"):
    run("make test")

if has_make_target("cleanup"):
    run("make cleanup")


print("order: Ok")
