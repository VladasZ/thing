#!/usr/bin/env python3

import os
import uuid


while True:
    os.system("sudo dd if=/dev/random of=" + str(uuid.uuid4()) + ".temp bs=1024 count=100")
