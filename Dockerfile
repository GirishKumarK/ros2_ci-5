FROM osrf/ros:galactic-desktop

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    ros-galactic-ros2-control \
    ros-galactic-ros2-controllers \
    ros-galactic-joint-state-publisher \
    ros-galactic-robot-state-publisher \
    ros-galactic-xacro \
    ros-galactic-nav2-bringup \
    ros-galactic-nav2-common \
    ros-galactic-nav2-core \
    ros-galactic-nav2-lifecycle-manager \
    ros-galactic-nav2-msgs \
    ros-galactic-nav2-planner \
    ros-galactic-nav2-recoveries \
    ros-galactic-nav2-util \
    ros-galactic-nav2-waypoint-follower \
    ros-galactic-urdf \
    ros-galactic-gazebo-ros \
    ros-galactic-gazebo-ros-pkgs \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-common-extensions \
    build-essential \
    git \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables for headless operation
ENV DISPLAY=:99
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV QT_X11_NO_MITSHM=1

# Clone TortoiseBot simulation packages
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws/src
RUN git clone -b ros2-galactic --recursive https://github.com/rigbetellabs/tortoisebot.git

# Clone tortoisebot_waypoints package for ROS 2
RUN git clone https://github.com/Hamz115/tortoisebot_waypoints_ros2.git

# Build the workspace
WORKDIR /ros2_ws
RUN /bin/bash -c "source /opt/ros/galactic/setup.bash && colcon build --packages-ignore tortoisebot_control --event-handler console_cohesion+"

# Set up environment
RUN echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]


