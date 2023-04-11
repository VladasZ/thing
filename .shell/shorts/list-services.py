#!/usr/bin/env python3

import os
import subprocess

# get current working directory
cwd = os.getcwd()

# loop through all directories in the current directory
for folder in os.listdir(cwd):
    # check if the folder name ends with "-service"

    if folder.endswith("-service"):

        # create the path to the migration directory
        migration_path = os.path.join(cwd, folder, "migrations")
        # check if the migration directory exists
        if os.path.exists(migration_path):
            print(folder)
