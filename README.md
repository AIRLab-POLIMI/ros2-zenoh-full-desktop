# ROS 2 Zenoh Full Desktop

<div style="text-align: center;">
  <img src="https://zenoh.io/img/zenoh-dragon-bg-150x163.png" alt="Zenoh Logo" width="150">
</div>
<div style="text-align: center;">
  <img src="https://images.squarespace-cdn.com/content/v1/606d378755a86f589aa297b7/1717136168404-CV7O6LD1M56PNET8G161/JazzyJalisco_Final.png" alt="Jazzy Jalisco Logo" width="150">
</div>

Zenoh route

Zenoh router is started as a backgroud process and everything is sourced as /zenoh_entrypoint.sh is triggered.

## Step 1: Pull the Docker Image
```bash
docker pull airlabpolimi/ros2-zenoh-full-desktop:jazzy
```

## Step 2: Start the Docker Container
In the first terminal, run:
```bash
docker run -it --name ros2-zenoh-container airlabpolimi/ros2-zenoh-full-desktop:jazzy
```

## Step 3: Run the ROS 2 TALKER Node
Inside the container (still in the first terminal), execute:
```bash
ros2 run demo_nodes_cpp talker
```

## Step 4: Access the Running Container
Open a new terminal and enter:
```bash
docker exec -it ros2-zenoh-container /bin/bash
```

## Step 5: Run the ROS 2 LISTENER Node
Inside the container (still in the second terminal), execute:
```bash
ros2 run demo_nodes_cpp listener
```
