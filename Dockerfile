# Use the ROS 2 Jazzy full desktop image as the base
FROM osrf/ros:jazzy-desktop-full

# Update and install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
        python3-pip \
        python3-colcon-common-extensions \
        git

# Create a workspace and clone the rmw_zenoh repository
RUN mkdir -p /root/ws_rmw_zenoh/src && \
    cd /root/ws_rmw_zenoh/src && \
    git clone https://github.com/ros2/rmw_zenoh.git

# Install dependencies using rosdep
RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
    rosdep update && \
    rosdep install --from-paths /root/ws_rmw_zenoh/src --ignore-src --rosdistro jazzy -y"

# Build the workspace
RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
    cd /root/ws_rmw_zenoh && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release"

# At the end of your Dockerfile
RUN echo 'source /ros_entrypoint.sh' >> /root/.bashrc && \
    echo 'source /root/ws_rmw_zenoh/install/setup.bash' >> /root/.bashrc

# Set the environment variable for RMW implementation
ENV RMW_IMPLEMENTATION=rmw_zenoh_cpp

# Copy the zenoh_entrypoint.sh into the image
COPY zenoh_entrypoint.sh /zenoh_entrypoint.sh
RUN chmod +x /zenoh_entrypoint.sh

# Expose the Zenoh router port (optional)
EXPOSE 7447

# Set the entrypoint to zenoh_entrypoint.sh
ENTRYPOINT ["/zenoh_entrypoint.sh"]
