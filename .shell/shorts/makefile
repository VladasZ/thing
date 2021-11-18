#!/usr/bin/env python3

import os
import sys
import uuid 

if len(sys.argv) < 2:
	raise Exception("Enter file size")

file_size = int(sys.argv[1])
file_name = uuid.uuid4().hex.upper()[0:6]

with open(file_name + "." + str(file_size) + "mb", 'wb') as fout:
    fout.write(os.urandom(file_size * 1024 * 1024))
