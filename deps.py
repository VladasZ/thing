#!/usr/bin/env python3

import os
import platform

is_windows = platform.system() == "Windows"
is_mac     = platform.system() == "Darwin"
is_linux   = platform.system() == "Linux"


def _get_home():
    if "HOME" in os.environ:
        return os.environ["HOME"]
    return os.path.expanduser("~")
    

home = _get_home()
deps_path = home + "/.rdeps/"

tools_path = deps_path + "tools/"

this_path = os.path.dirname(os.path.abspath(__file__))


def run(string):
    print(string)
    if os.system(string):
        raise Exception("Shell script has failed")


def clone(rep, destination=""):
    if not os.path.exists(destination):
        run("git clone --recursive https://github.com/vladasz/" + rep + " " + destination)


def link_deps():
    clone("tools", tools_path)
    try:
        print("Symlimk: " + deps_path + " to: " + this_path + "/.rdeps")
        os.symlink(deps_path, this_path + "/.rdeps")
    except FileExistsError:
        print("exists")


def linux_setup():
    run("sudo apt update")
    run("sudo apt -y install curl pkg-config libssl-dev make cmake gcc g++ unzip automake libtool-bin")
    run("curl https://sh.rustup.rs -sSf | sh -s -- -y")


link_deps()

if is_linux:
    linux_setup()
