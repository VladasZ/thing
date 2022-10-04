#!/usr/bin/env python3

import os

print("ELASTIO_ARTIFACTS_SOURCE: " + os.environ["ELASTIO_ARTIFACTS_SOURCE"])

print("AWS_PROFILE=assuriodev cargo trix artifacts upload")
os.system("AWS_PROFILE=assuriodev cargo trix artifacts upload")
