#!/usr/bin/env python

import os
import platform

def create_symlink(src, dst):
    target_is_directory = os.path.isdir(src)

    if platform.system() == 'Windows':
        try:
            os.symlink(src, dst, target_is_directory=target_is_directory)
            print(f"Symlink created: {src} -> {dst}")
        except:
            print(f"Failed to create symlink: {src} -> {dst}")
    else:
        # try:
        os.symlink(src, dst)
        print(f"Symlink created: {src} -> {dst}")
        # except:
        #     print(f"Failed to create symlink: {src} -> {dst}")

if __name__ == '__main__':
    src = '~/Dropbox/.ssh'
    dst = '~/.ssh'

    create_symlink(os.path.expanduser(src), os.path.expanduser(dst))
