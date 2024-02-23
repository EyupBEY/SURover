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
# https://wiki.ros.org/ROS/Tutorials/UnderstandingTopics

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

### rostopic type - ROS Messages - Shows the type of the message
> rostopic type [topic]
    > rostopic type /turtle1/cmd_vel
        To see the details:
        > rosmsg show geometry_msgs/Twist

### rostopic pub - Publishes data
> rostopic pub [topic] [msg_type] [args]
    > rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, 1.8]'
        -1                       (means only publish one message and exit)
        /turtle1/cmd_vel         (the name of the topic to publish)
        geometry_msgs/Twist      (type of the message)
        --                       (tells the option parser that none of the following arguments is an option. This is required in cases where your arguments have a leading dash -, like negative numbers.)
        The arguments are in YAML syntax(https://wiki.ros.org/ROS/YAMLCommandLine)
    Turtle has stopped moving why because we need 1 Hz to keep moving using -r:
    > rostopic pub /turtle1/cmd_vel geometry_msgs/Twist -r 1 -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, -1.8]'
    Press the refresh button in the upper-left in rqt_graph.
    > rostopic echo /turtle1/pose        (U can see the data published by our turtlesim)

### rostopic hz - Reports the average rate at which data is published
> rostopic hz [topic]
    > rostopic hz /turtle1/pose

> rostopic type /turtle1/cmd_vel | rosmsg show

## rqt_plot
It displays a scrolling time plot of the data published on topics.
Note: If you're using electric or earlier, rqt is not available. Use rxplot instead.
> rosrun rqt_plot rqt_plot
Type to the Topic bar: /turtle1/pose/x  or  /turtle1/pose/y   or /turtle1/pose/theta
-------------------------------------------------------------------------------------------
# https://wiki.ros.org/ROS/Tutorials/UnderstandingServicesParams

ROS Services are another way that nodes can communicate with each other. Services allow nodes to send a request and receive a response.

> rosservice list                   print information about active services
> rosservice type [service]         print service type
    > rosservice type /clear
        std_srvs/Empty : Means it is empty service. it takes no arguments (i.e. it sends no data when making a request and receives no data when receiving a response)
> rosservice call [service] [args]  call the service with the provided args
    > rosservice call /clear
        It clears the turtlesim screen
        It has no arguments because /clear is type of empty
> rosservice find                   find services by service type
> rosservice uri                    print service ROSRPC uri

