
<p align="center">
  <a href="https://foxglove.dev" target="_blank">
    <img src="https://cdn.prod.website-files.com/66a36245725199d12625c1d5/66cc0d0a97f1a44cf47fffc1_logo-icon-round.png" alt="Foxglove Logo Icon" style="height: 150px; width: auto; margin-right: 20px;">
  </a>
  <a href="https://zenoh.io" target="_blank">
    <img src="https://zenoh.io/img/zenoh-dragon-bg-150x163.png" alt="Zenoh Logo">
  </a>
</p>

<p align="center">
  <a href="https://hub.docker.com/repository/docker/airlabpolimi/ros2-zenoh-full-desktop">
    <img src="https://img.shields.io/badge/Docker%20Hub-Repository-blue?logo=docker" alt="Docker Hub">
  </a>
</p>

---
# ROS 2 Jazzy Jalisco Full Desktop + FoxGlove-Studio Bridge + Zenoh RMW

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

---
## Authors
- **Mirko Usuelli**, Ph.D. Candidate @ AIRLab, Politecnico di Milano [[LinkedIn](https://www.linkedin.com/in/mirko-usuelli-64992b155/)][[GitHub](https://github.com/mirkousuelli)]

## Laboratory
- [LinkedIn](https://it.linkedin.com/company/airlab-polimi) : Academic news
- [Instagram](https://www.instagram.com/airlab_polimi/) : Student news