#!/usr/bin/env python3

import sys
import subprocess

def main():
    if len(sys.argv) != 2:
        print("Usage: tag <tag_name>")
        sys.exit(1)

    tag_name = sys.argv[1]

    try:
        subprocess.run(["git", "tag", tag_name], check=True)
        subprocess.run(["git", "push", "origin", tag_name], check=True)
        print(f"Successfully created and pushed tag: {tag_name}")
    except subprocess.CalledProcessError as e:
        print(f"Error: Failed to create or push tag: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
