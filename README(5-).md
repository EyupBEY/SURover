# https://wiki.ros.org/ROS/Tutorials/UnderstandingNodes

## Graph Concepts
Nodes: A node is an executable that uses ROS to communicate with other nodes by ROS client library.
    Client Libs: rospy, and roscpp
Messages: ROS data type used when subscribing or publishing to a topic.
Topics: Nodes can publish messages to a topic as well as subscribe to a topic to receive messages.
Master: Name service for ROS (i.e. helps nodes find each other)
rosout: ROS equivalent of stdout/stderr
roscore: Master + rosout + parameter server (parameter server will be introduced later)

## Run first when using ROS
> roscore
if doesn't work, it is probably because /.ros is owned by root:
> sudo chown -R <your_username> ~/.ros

## Using rosnode(open new terminal)
> rosnode list
    /rosout             -->Active nodes are listed
> rosnode info /rosout

## rosrun - Allows you to use the package name to directly run a node within a package
> rosrun [package_name] [node_name]
    > rosrun turtlesim turtlesim_node

You can change the name, but first close the previous terminal:
> rosrun turtlesim turtlesim_node __name:=my_turtle

## Clean the rosnode list with:
> rosnode cleanup

To test that it's up:
> rosnode ping my_turtle
-------------------------------------------------------------------------------------------
## Setup
> roscore                                 (new terminal)
> rosrun turtlesim turtlesim_node         (new terminal)
> rosrun turtlesim turtle_teleop_key      (new terminal) use arrow keys to move turtle make sure your typings recorded in the terminal

## ROS Topics
The turtlesim_node and the turtle_teleop_key node are communicating with each other over a ROS Topic.
turtle_teleop_key is publishing the key strokes on a topic, while turtlesim subscribes to the same topic to receive the key strokes.

## Using rqt_graph
> sudo apt-get install ros-<distro>-rqt
> sudo apt-get install ros-<distro>-rqt-common-plugins
> rosrun rqt_graph rqt_graph
    Uncheck the debug.
    The text abowed the arrow is TOPIC.
    The semi eliptics are NODEs.
        Nodes are communicating via topic.

## rostopic
> rostopic -h
or press <tab> to see sub-commands.
> rostopic echo [topic]
    > rostopic list                                 (To see the topics)
    > rostopic echo /turtle1/cmd_vel                (/turtle1/cmd_vel is a topic mentioned in rqt_graph)

### rostopic list
> rostopic list -h
> rostopic list -v                                   (To see verbose option)
publisher (turtle_teleop_key), subscriber (turtlesim_node)

### rostopic type - Shows the type of the messege
> rostopic type [topic]
    > rostopic type /turtle1/cmd_vel
        To see the details:
        > rosmsg show geometry_msgs/Twist

