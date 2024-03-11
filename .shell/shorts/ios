#!/usr/bin/env python3

import os


def cd(path):
    os.chdir(path)


def convert_path(path):
    if os.path.sep != '/':
        path = path.replace(os.path.sep, '/')
    return path


def full_path(path='.'):
    return convert_path(os.path.abspath(os.path.expanduser(path)))


def get_files(path='.'):
    return os.listdir(full_path(path))


cd("mobile/iOS")


for file in get_files():
    extension = os.path.splitext(file)[1]
    if extension == ".xcodeproj":
        os.system("open " + file)
