#!/usr/bin/env python3

import os
import platform
import sys


def create_symlink(src, dst):
    target_is_directory = os.path.isdir(src)

    if platform.system() == "Windows":
        try:
            os.symlink(src, dst, target_is_directory=target_is_directory)
            print(f"Symlink created: {src} -> {dst}")
        except:
            a = 4
    else:
        try:
            os.symlink(src, dst)
            print(f"Symlink created: {src} -> {dst}")
        except:
            a = 4


if __name__ == "__main__":
    src = sys.argv[1]
    dst = sys.argv[2]

    create_symlink(os.path.expanduser(src), os.path.expanduser(dst))
