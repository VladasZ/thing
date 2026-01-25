#!/usr/bin/env python3

import os
import sys
from contextlib import suppress


def create_symlink(src, dst):
    if os.path.exists(dst) and not os.path.islink(dst):
        print(
            f"Error: '{dst}' exists and is a regular file/directory. Manual deletion required."
        )
        return

    target_is_directory = os.path.isdir(src)

    with suppress(FileExistsError):
        os.symlink(src, dst, target_is_directory=target_is_directory)
        print(f"Symlink created: {src} -> {dst}")


if __name__ == "__main__":
    src = sys.argv[1]
    dst = sys.argv[2]

    create_symlink(os.path.expanduser(src), os.path.expanduser(dst))
