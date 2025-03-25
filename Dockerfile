# Use the ROS 2 Jazzy full desktop image as the base
FROM osrf/ros:humble-desktop-full

# Update and install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
        python3-pip \
        python3-colcon-common-extensions \
        git \
        ros-humble-rosbag2-storage-mcap \
        ros-humble-demo-nodes-cpp \
        ros-humble-foxglove-bridge \
        ros-humble-point-cloud-transport \
        ros-humble-point-cloud-transport-plugins \
        ros-humble-image-transport \
        ros-humble-image-transport-plugins \
        ros-humble-rosbag2-compression \
        ros-humble-rosbag2-compression-zstd \
        ros-humble-pcl-ros \
        ros-humble-tf2-ros

# Create a workspace in /opt
RUN mkdir -p /opt/ws_rmw_zenoh/src

# Clone the rmw_zenoh repository (as root)
RUN git clone -b humble https://github.com/ros2/rmw_zenoh.git /opt/ws_rmw_zenoh/src/rmw_zenoh

# Install dependencies using rosdep (as root)
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
    rosdep update && \
    rosdep install --from-paths /opt/ws_rmw_zenoh/src --ignore-src --rosdistro humble -y"

# Build the workspace (as root)
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
    cd /opt/ws_rmw_zenoh && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release"

# Set the environment variable for RMW implementation
ENV RMW_IMPLEMENTATION=rmw_zenoh_cpp

# Source setup scripts globally
RUN echo 'source /zenoh_entrypoint.sh' >> /etc/bash.bashrc

# Copy the zenoh_entrypoint.sh into the image and adjust permissions
COPY zenoh_entrypoint.sh /zenoh_entrypoint.sh
RUN chmod +x /zenoh_entrypoint.sh

# Expose the Zenoh router port (optional)
EXPOSE 7447/udp
EXPOSE 7447/tcp

# Expose the Foxglove ROS Bridge port (optional)
EXPOSE 8765/tcp
EXPOSE 8765/udp

# Set the entrypoint to zenoh_entrypoint.sh
ENTRYPOINT ["/bin/bash"]
