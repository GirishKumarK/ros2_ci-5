#!/bin/bash
set -e

# Start virtual X server
Xvfb :99 -screen 0 1024x768x16 &

# Source ROS 2 Galactic setup file
source /opt/ros/galactic/setup.bash

# Source the workspace setup file
source /ros2_ws/install/setup.bash

# Launch TortoiseBot bringup 
ros2 launch tortoisebot_bringup bringup.launch.py use_sim_time:=True gui:=false &

# Wait for the bringup to complete
sleep 10

# Run the TortoiseBot action server
ros2 run tortoisebot_waypoints tortoisebot_action_server &

# Wait for the action server to start
sleep 5

# Run the tests with increased timeout
GOAL_X=0.5 GOAL_Y=0.5 colcon test --packages-select tortoisebot_waypoints --event-handler=console_direct+ --pytest-args -o timeout=300

# Keep the container running
exec "$@"