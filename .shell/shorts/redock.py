#!/usr/bin/env python3

import sys
import subprocess

status = sys.argv[1] is not None and sys.argv[1] == "st"

if not status:
    subprocess.run(["sudo", "docker-compose", "stop"])
    subprocess.run(["sudo", "docker-compose", "rm", "-y"])
    subprocess.run(["sudo", "docker-compose", "up", "-d"])

subprocess.run(["sudo", "docker-compose", "ps"])
