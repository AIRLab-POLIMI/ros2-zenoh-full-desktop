#!/bin/bash
set -e

# Source the ROS 2 environment
source /opt/ros/jazzy/setup.bash

# Source the workspace overlay
source /opt/ws_rmw_zenoh/install/setup.bash

# Check if rmw_zenohd is already running
if ! pgrep -x "rmw_zenohd" > /dev/null
then
    # Start rmw_zenohd in the background without verbosity
    ros2 run rmw_zenoh_cpp rmw_zenohd >/dev/null 2>&1 &
fi

# Execute any passed command or start an interactive shell
if [ "$#" -eq 0 ]; then
    exec bash
else
    exec "$@"
fi
