#!/usr/bin/env python3

import os
import sys


pg = "pg" in sys.argv
k = "k" in sys.argv

if pg:
    os.system("ssh -L 5432:127.0.0.1:5432 my")
    exit(0)

if k:
    os.system("ssh -L 8080:127.0.0.1:8080 pi")
    exit(0)
