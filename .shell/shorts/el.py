#!/usr/bin/env python3

import os
import sys

args = ""

for arg in sys.argv[1:]:
    args += arg + " "

print(args)

os.system("sudo -E ./target/debug/elastio " + sys.argv[1] + " --foreground")
