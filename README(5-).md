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

## rosservice
ROS Services are another way that nodes can communicate with each other. Services allow nodes to send a request and receive a response.

> rosservice list                   print information about active services
> rosservice type [service]         print service type
    > rosservice type /clear
        std_srvs/Empty : Means it is empty service. it takes no arguments (i.e. it sends no data when making a request and receives no data when receiving a response)
    > rosservice type /spawn | rossrv show
    > rosservice call /spawn 2 2 0.2 "optionalNameSection"    creates a new turtle at given location and orientation
> rosservice call [service] [args]  call the service with the provided args
    > rosservice call /clear
        It clears the turtlesim screen
        It has no arguments because /clear is type of empty
> rosservice find                   find services by service type
> rosservice uri                    print service ROSRPC uri

## rosparam
The Parameter Server can store: integers, floats, boolean, dictionaries, and lists.
rosparam uses the YAML markup language for syntax:
1 is an integer, 1.0 is a float, one is a string, true is a boolean, [1, 2, 3] is a list of integers, and {a: b, c: d} is a dictionary.
> rosparam list                        list parameter names
> rosparam set [param_name]            set parameter
    > rosparam set /turtlesim/background_r 150         sets red channel of the background color 150
> rosparam get [param_name]            get parameter
    > rosparam get /turtlesim/background_g
        86
    > rosparam get /                   Shows the contents of the entire Parameter Server
        rosdistro: 'noetic

        '
        roslaunch:
        uris:
            host_nxt__43407: http://nxt:43407/
        rosversion: '1.15.5

        '
        run_id: 7ef687d8-9ab7-11ea-b692-fcaa1494dbf9
        turtlesim:
        background_b: 255
        background_g: 86
        background_r: 69
> rosparam dump [file_name] [namespace]                        dump parameters to file to use later
    > rosparam dump params.yaml
> rosparam load [file_name] [namespace]                        load parameters from file
    > rosparam load params.yaml copy_turtle                    load the previous yaml file into copy_turtle which is a new workspace
> rosparam delete                      delete parameter

To the changes affect:
> rosservice call /clear
--------------------------------------------------------------------------------------------
# https://wiki.ros.org/ROS/Tutorials/UsingRqtconsoleRoslaunch

## rqt_console and rqt_logger_level
ROS's logging framework to display output from nodes. rqt_logger_level allows us to change the verbosity level (DEBUG, WARN, INFO, and ERROR) of nodes as they run.
> rosrun rqt_console rqt_console
> rosrun rqt_logger_level rqt_logger_level

## roslaunch
> cd ~/Desktop/SuRover
> source devel/setup.bash
> roscd myFirstPackage
> roslaunch [package] [filename.launch]      Starts nodes as defined in a launch file.
> roscd myFirstPackage
> mkdir launch
> cd launch
Create a file named turtlemimic.launch

<launch> <!-- To identify as a launch file -->

    <group ns="turtlesim1">
    <node pkg="turtlesim" name="sim" type="turtlesim_node"/>
    </group>

    <group ns="turtlesim2">
    <node pkg="turtlesim" name="sim" type="turtlesim_node"/>
    </group>

    <!-- 2 groups with 2 turtlesim nodes with a name of sim. Abowed 6 lines allows us to start two simulators without having name conflicts. -->


    <node pkg="turtlesim" name="mimic" type="mimic">
    <remap from="input" to="turtlesim1/turtle1"/>
    <remap from="output" to="turtlesim2/turtle1"/>
    </node>

    <!-- Here we start the mimic node with the topics input and output renamed to turtlesim1 and turtlesim2. This renaming will cause turtlesim2 to mimic turtlesim1. -->

</launch>

> roslaunch myFirstPackage turtlemimic.launch
> rostopic pub /turtlesim1/turtle1/cmd_vel geometry_msgs/Twist -r 1 -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, -1.8]'

Run belowed command and select Plugins > Introspection > Node Graph:
> rqt
or
> rqt_graph