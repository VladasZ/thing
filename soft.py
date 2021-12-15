#!/usr/bin/env python3

import os
import platform

is_windows = platform.system() == "Windows"
is_mac     = platform.system() == "Darwin"
is_linux   = platform.system() == "Linux"


def run(string):
    print(string)
    if os.system(string):
        raise Exception("Shell script has failed")

if is_linux:
    run("sudo snap install telegram-desktop")
    