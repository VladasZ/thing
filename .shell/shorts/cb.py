#!/usr/bin/env python3

import os
import sys
import subprocess

os.system("cargo fmt --all")

if len(sys.argv) > 1:
    os.system("cargo build -p" + sys.argv[1])
else:

    # Run the `cargo workspaces list` command and get the output
    output = subprocess.check_output(['cargo', 'workspaces', 'list']).decode('utf-8')

    # Extract the project names from the output
    project_names = [line.split(' ')[0] for line in output.split('\n') if line]

    print(project_names)

    # Run `cargo build -p` for each project
    for project_name in project_names:
        subprocess.run(['cargo', 'build', '-p', project_name])
