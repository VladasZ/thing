#!/usr/bin/env python3

import os
import sys
import platform

is_windows = platform.system() == "Windows"
is_mac     = platform.system() == "Darwin"
is_linux   = platform.system() == "Linux"

is_unix = is_mac or is_linux

orig = sys.argv[1]
link = sys.argv[2]

is_dir = os.path.isdir(orig)

if is_dir:
    print("Linking directory")
else:
    print("Linking file")


def run(string):
    print(string)
    if os.system(string):
        raise Exception("Shell script has failed")


def link_unix(orig, link):
    run("ln -s " + orig + " " + link)

def link_win(orig, link):
    raise Exception("lalal kokodksodsokd")

if is_unix:
    link_unix(orig, link)
elif is_windows:
    link_win(orig, link)
else:
    raise Exception("yak yak yak yak yak yak?")

print("Linked " + orig + " to: " + link)
