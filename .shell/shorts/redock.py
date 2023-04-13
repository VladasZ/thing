#!/usr/bin/env python3

import sys
import subprocess

status = False
stop = False


if len(sys.argv) > 1:
    status = sys.argv[1] == "st"
    stop = sys.argv[1] == "stop"


if status:
    subprocess.run(["sudo", "docker-compose", "ps"])
    exit(0)

if stop:
    subprocess.run(["sudo", "docker-compose", "stop"])
    exit(0)

subprocess.run(["sudo", "docker-compose", "stop"])
subprocess.run(["sudo", "docker-compose", "rm", "-y"])
subprocess.run(["sudo", "docker-compose", "up", "-d"])
subprocess.run(["sudo", "docker-compose", "ps"])
