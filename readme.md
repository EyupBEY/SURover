# Introduction to ROS | Part - 1 | ROS Learning Series

To visualize:
```
roslaunch gazebo_ros empty_world.launch
```

To make simulations, debuggings, and to get outputs:
```
rosrun rviz rviz
```

---

# Simulating TurtleBot3 Robot | Part - 2 | ROS Learning Series

https://emanual.robotis.com/docs/en/platform/turtlebot3/simulation/

```
sudo apt-get install ros-noetic-navigation
```

```
cd SuRover
mkdir -p ros-learning-series/src
cd ros-learning-series/src
git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b noetic-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
cd .. && catkin_make
```

```
cd SuRover/ros-learning-series/src
source devel/setup.bash
export TURTLEBOT3_MODEL=burger
roslaunch turtlebot3_gazebo turtlebot3_empty_world.launch
```
* instead of **turtlebot3_empty_world.launch** you may want to use turtlebot3_world.launch
```
cd SuRover/ros-learning-series/src
source devel/setup.bash
export TURTLEBOT3_MODEL=burger
roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch
```