#!/usr/bin/env python3

import sys
import psutil



def kill_process_using_port(port):
    for proc in psutil.process_iter():
        try:
            for conn in proc.connections(kind='inet'):
                if conn.laddr.port == port:
                    print(f"Killing process {proc.pid} (port {port})")
                    proc.kill()
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass


if len(sys.argv) > 1:
    kill_process_using_port(sys.argv[1])
else:
    print("No arguments provided")
