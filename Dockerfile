# Use the ROS 2 Jazzy full desktop image as the base
FROM osrf/ros:jazzy-desktop-full

# Update and install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
        python3-pip \
        python3-colcon-common-extensions \
        git

# Create a workspace in /opt
RUN mkdir -p /opt/ws_rmw_zenoh/src

# Clone the rmw_zenoh repository (as root)
RUN git clone https://github.com/ros2/rmw_zenoh.git /opt/ws_rmw_zenoh/src/rmw_zenoh

# Install dependencies using rosdep (as root)
RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
    rosdep update && \
    rosdep install --from-paths /opt/ws_rmw_zenoh/src --ignore-src --rosdistro jazzy -y"

# Build the workspace (as root)
RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
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

# Set the entrypoint to zenoh_entrypoint.sh
ENTRYPOINT ["bash"]
