#!/bin/bash

# Check if the socket exists
if [ ! -S "$NIRI_SOCKET" ]; then
    echo "Error: Niri socket not found at $NIRI_SOCKET" >&2
    exit 1
fi

# Send command to get workspace information
echo "get_tree" | socat - UNIX-CONNECT:"$NIRI_SOCKET" 
