#!/usr/bin/env python3

import os
import sys

if len(sys.argv) > 1:
    os.system("cargo build -p" + sys.argv[1])
else:
    os.system("cargo build --all")
