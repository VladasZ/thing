#!/usr/bin/env python3

import os

print("ELASTIO_ARTIFACTS_SOURCE: " + os.environ["ELASTIO_ARTIFACTS_SOURCE"])

os.system("AWS_PROFILE=assuriodev cargo trix artifacts upload")
