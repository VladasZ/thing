#!/usr/bin/env python3
import os
import sys
import platform

sys.path.append(os.path.expanduser("~/.deps/build_tools"))


import Shell

Shell.run_string("cd build")
Shell.run_string("cmake --graphviz=graph ..")
Shell.run_string("dot graph -Tsvg -o graph.svg")
