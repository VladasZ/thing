#!/usr/bin/env python3

import os
import sys


os.system("git add -A")
os.system("git commit -m \"" + sys.argv[1] + "\"")
os.system("git push")
