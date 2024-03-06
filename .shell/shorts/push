#!/usr/bin/env python3

import os
import sys

args = ""

for arg in sys.argv[1:]:
    args += arg + " "

os.system("git stash")
os.system("git pull")
os.system("git stash pop")

os.system("git add -A")
os.system("git commit -m \"" + args + "\"")
os.system("git push")
