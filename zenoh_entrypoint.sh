#!/bin/bash
set -e

# Source the ROS 2 environment
source /opt/ros/humble/setup.bash

# Source the workspace overlay
source /opt/ws_rmw_zenoh/install/setup.bash

# Check if rmw_zenohd is already running
if ! pgrep -x "rmw_zenohd" > /dev/null
then
    # Start rmw_zenohd in the background without verbosity
    ros2 run rmw_zenoh_cpp rmw_zenohd >/dev/null 2>&1 &
fi

# Check if Foxglove ROS Bridge is already running
if ! pgrep -f "foxglove_bridge" > /dev/null
then
    # Start the Foxglove ROS Bridge in the background on port 8765
    ros2 run foxglove_bridge foxglove_bridge foxglove_bridge_launch.xml --port 8765 >/dev/null 2>&1 &
fi
