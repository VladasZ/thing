#!/usr/bin/env python3

import sys
import subprocess

status = False
start = False
stop = False
rm = False


if len(sys.argv) > 1:
    status = sys.argv[1] == "st"
    stop = sys.argv[1] == "stop"
    stop = sys.argv[1] == "start"
    rm = sys.argv[1] == "rm"


if status:
    subprocess.run(["sudo", "docker-compose", "ps"])
    exit(0)

if start:
    subprocess.run(["sudo", "docker-compose", "up", "-d"])
    subprocess.run(["sudo", "docker-compose", "ps"])
    exit(0)

if stop:
    subprocess.run(["sudo", "docker-compose", "stop"])
    exit(0)

if rm:
    subprocess.run(["sudo", "docker-compose", "stop"])
    subprocess.run(["sudo", "docker-compose", "rm", "-y"])
    exit(0)

subprocess.run(["sudo", "docker-compose", "stop"])
subprocess.run(["sudo", "docker-compose", "rm", "-y"])
subprocess.run(["sudo", "docker-compose", "up", "-d"])
subprocess.run(["sudo", "docker-compose", "ps"])
