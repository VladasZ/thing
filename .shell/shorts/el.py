#!/usr/bin/env python3

import os
import sys

os.system("sudo -E ./target/debug/elastio " + sys.argv[1] + " --foreground")
