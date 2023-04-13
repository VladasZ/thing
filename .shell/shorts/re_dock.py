#!/usr/bin/env python3

import subprocess


subprocess.run(["sudo", "docker-compose", "stop"])
subprocess.run(["sudo", "docker-compose", "rm", "-y"])
subprocess.run(["sudo", "docker-compose", "up", "-d"])
subprocess.run(["sudo", "docker-compose", "ps"])
