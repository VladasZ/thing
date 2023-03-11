#!/usr/bin/env python3

import subprocess

subprocess.run(["cargo", "fmt", "--all"])

try:
    subprocess.run(["taplo", "--version"], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
except subprocess.CalledProcessError:
    subprocess.run(["cargo", "install", "taplo-cli"])

subprocess.run(["taplo", "fmt"])
