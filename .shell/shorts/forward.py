#!/usr/bin/env python3

import os
import sys

pg = False
cucu = False
stop = False


if len(sys.argv) > 1:
    pg = sys.argv[1] == "pg"
    cucu = sys.argv[1] == "cucu"


ports = """-L 9092:127.0.0.1:9092 \
-L 3030:127.0.0.1:3030 \
-L 4566:127.0.0.1:4566 \
-L 4571:127.0.0.1:4571 \
-L 5432:127.0.0.1:5432 \
-L 6379:127.0.0.1:6379 \
-L 9202:127.0.0.1:9201 \
-L 9202:127.0.0.1:9202 \
-R 3588:127.0.0.1:3588 \
-R 3589:127.0.0.1:3589 \
"""

if pg:
    # ports = "-R 5432:127.0.0.1:5432"
    ports = "-L 5432:127.0.0.1:5432"

if cucu:
    ports = "-L 9092:127.0.0.1:9092 -L 6379:127.0.0.1:6379 -L 4566:127.0.0.1:4566"

print(ports)

os.system("ssh " + ports + " v")
