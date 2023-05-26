#!/usr/bin/env python3

import os
import datetime
import subprocess

def download_file(hostname, remote_path, local_path):
    try:
        subprocess.run(["scp", f"{hostname}:{remote_path}", local_path])
        print(f"File downloaded successfully from {hostname} to {local_path}")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while downloading the file: {str(e)}")

hostname = "my"

remote_path = "~/money/base.sqlite"
local_path = os.path.expanduser("~/money/base.sqlite")
backup_path = os.path.expanduser("~/Dropbox/Archive/Spesogon/base_" + datetime.datetime.now().strftime("%Y-%m-%d %H-%M-%S") + ".sqlite")

download_file(hostname, remote_path, local_path)
download_file(hostname, remote_path, backup_path)
