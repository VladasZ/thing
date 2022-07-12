#!/usr/bin/env python3

import os
import sys

args = ""

for arg in sys.argv[1:]:
    args += arg + " "

command = "sudo -E ./target/debug/elastio " + args + " --foreground"

print("command: " + command)

os.system(command)
