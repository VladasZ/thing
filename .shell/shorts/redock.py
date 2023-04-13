#!/usr/bin/env python3

import sys
import subprocess

status = False

if len(sys.argv) > 1:
    status = sys.argv[1] == "st"

if not status:
    subprocess.run(["sudo", "docker-compose", "stop"])
    subprocess.run(["sudo", "docker-compose", "rm", "-y"])
    subprocess.run(["sudo", "docker-compose", "up", "-d"])

subprocess.run(["sudo", "docker-compose", "ps"])
