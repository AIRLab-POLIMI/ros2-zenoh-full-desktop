#!/bin/bash
set -e

# Source the original ros_entrypoint.sh
source "/ros_entrypoint.sh"

# Source the rmw_zenoh_cpp workspace
source "/root/ws_rmw_zenoh/install/setup.bash"

# Ensure the log directory exists
mkdir -p /root/logs/

# Check if rmw_zenohd is already running
if ! pgrep -x "rmw_zenohd" > /dev/null; then
    # Start the Zenoh router in the background
    nohup ros2 run rmw_zenoh_cpp rmw_zenohd > /root/logs/rmw_zenohd.log 2>&1 &
fi

# Start an interactive shell
exec "$SHELL"
