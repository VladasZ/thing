#!/usr/bin/env python3

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


# example usage:
kill_process_using_port(3030)
