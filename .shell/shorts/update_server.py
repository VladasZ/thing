#!/usr/bin/env python3

import os

def run(string, fail_on_error=True):
    print(string)
    if os.system(string):
        if fail_on_error:
            raise Exception("Shell script has failed")

run("ssh my tmux kill-server", fail_on_error=False)
run("scp ms_build my:ms_build")
run("ssh my chmod +x ./ms_build")
run("ssh my tmux new-session -d \'sudo -E ./ms_build\'")
run("ssh my tmux list-sessions")
