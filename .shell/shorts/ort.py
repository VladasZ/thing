#!/usr/bin/env python3

import psutil
import socket

# Get a list of all network connections
connections = psutil.net_connections()

# Print header row
print("Proto\tLocal Address\tForeign Address\tState\tPID/Program name")

# Iterate through each network connection and print its details
for conn in connections:
    # Get protocol name (TCP, UDP, etc.)
    proto = "TCP" if conn.type == socket.SOCK_STREAM else "UDP"

    # Get local and foreign addresses as strings
    local_addr = f"{conn.laddr.ip}:{conn.laddr.port}"
    foreign_addr = f"{conn.raddr.ip}:{conn.raddr.port}" if conn.raddr else ""

    # Get connection state
    state = conn.status

    # Get process ID and program name
    pid = conn.pid or "-"
    pname = psutil.Process(pid).name() if pid != "-" else "-"

    # Print connection details
    print(f"{proto}\t{local_addr}\t{foreign_addr}\t{state}\t{pid}/{pname}")
