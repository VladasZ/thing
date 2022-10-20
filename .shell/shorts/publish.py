#!/usr/bin/env python3

import os
import sys

if len(sys.argv) > 1:
    os.system("cargo publish -p" + sys.argv[1] + " --allow-dirty")
else:
    os.system("cargo publish --allow-dirty")
