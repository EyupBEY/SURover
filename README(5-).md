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
--------------------------------------------------------------------------------------------
# https://wiki.ros.org/ROS/Tutorials/UsingRosEd

## rosed - edit a file within a package by using the package name rather than having to type the entire path to the package.
> rosed [package_name] [filename]
    > rosed roscpp Logger.msg
    > rosed myFirstPackage turtlemimic.launch
Note: The default editor for rosed is vim. Thus, the abowed code probably won't work:
Edit ~/.bashrc file to include:
> export EDITOR='nano -w'
or
> export EDITOR='emacs -nw'
if you prefer.
To check:
> echo $EDITOR
--------------------------------------------------------------------------------------------
# https://wiki.ros.org/ROS/Tutorials/CreatingMsgAndSrv

## msg (message) - A simpe text files that are used to generate source code for messages in different languages. They are stored in the msg directory of a package

### Simple text files with a field type and field name per line.

#### Field Types:
    Header - contains a timestamp and coordinate frame information. You will frequently see the first line in a msg file have Header header.
    int8, int16, int32, int64 (plus uint*)
    float32, float64
    string
    time, duration
    other msg files
    variable-length array[] and fixed-length array[C]

> roscd myFirstPackage
> mkdir msg
Here is an example of a msg that uses a Header, a string primitive, and two other msgs:
    Header header
    string child_frame_id
    geometry_msgs/PoseWithCovariance pose
    geometry_msgs/TwistWithCovariance twist
    string first_name
    string last_name
    uint8 age
    uint32 score

Add this lines to package.xml because we need to make sure that the msg files are turned into source code for C++, Python, and other languages:
    <build_depend>message_generation</build_depend>
    <exec_depend>message_runtime</exec_depend>
at build time, we need "message_generation",
while at runtime, we only need "message_runtime"

Add the "message_generation" dependency to the "find_package" call which already exists in your myFirstPackage/CMakeLists.txt so that you can generate messages.

Modify the existing text to add message_generation before the closing parenthesis
find_package(catkin REQUIRED COMPONENTS
   roscpp
   rospy
   std_msgs
   message_generation
)

catkin_package(
  ...
  CATKIN_DEPENDS message_runtime ...
  ...)

add_message_files(
  FILES
  Num.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

Now we are ready to generate source files from your msg definition.

Check 
> rosmsg show [message type]
    > rosmsg show myFirstPackage/Num
    or
    > rosmsg show Num

## srv (service) - A file that describes a service, it is composed of: request & response. They are stored in the srv directory.
request and a response parts are separated by a '---' line. Here is an example of a srv file(A and B are request, Sum is response):
    int64 A
    int64 B
    ---
    int64 Sum

> roscd myFirstPackage
> mkdir srv
Instead of creating a srv definition by hand we copy an existing from another package by using roscp.
> roscp [package_name] [file_to_copy_path] [copy_path]
    > roscp rospy_tutorials AddTwoInts.srv srv/AddTwoInts.srv

Add this lines to package.xml because we need to make sure that the msg files are turned into source code for C++, Python, and other languages:
    <build_depend>message_generation</build_depend>
    <exec_depend>message_runtime</exec_depend>
at build time, we need "message_generation",
while at runtime, we only need "message_runtime"

Modify the existing text to add message_generation before the closing parenthesis
find_package(catkin REQUIRED COMPONENTS
   roscpp
   rospy
   std_msgs
   message_generation
)

add_service_files(
  FILES
  AddTwoInts.srv
)

Check
> rossrv show <service type>
    > rossrv show myFirstPackage/AddTwoInts

## Common step for msg and srv
Now that we have made some new messages we need to make our package again:

In your catkin workspace
> roscd myFirstPackage
> cd ../..

> catkin_make                (makes (compiles) a ROS package)
or another alternative:
> catkin build               (makes (compiles) a ROS package in an isolated manner while maintaining efficiency due to parallelisation)

> cd -

Any .msg file in the msg directory will generate code for use in all supported languages:
    The C++ message header file will be generated in ~/catkin_ws/devel/include/beginner_tutorials/
    The Python script will be created in ~/catkin_ws/devel/lib/python2.7/dist-packages/beginner_tutorials/msg
    The lisp file appears in ~/catkin_ws/devel/share/common-lisp/ros/beginner_tutorials/msg/
Similarly, any .srv files in the srv directory will have generated code in supported languages:
    For C++, this will generate header files in the same directory as the message header files.
    For Python and Lisp, there will be an 'srv' folder beside the 'msg' folders.
--------------------------------------------------------------------------------------------

# https://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28python%29
"Node" is the ROS term for an executable that is connected to the ROS network.

Here we'll create the publisher ("talker") node which will continually broadcast a message:

Add the following to your CMakeLists.txt(This makes sure the python script gets installed properly, and uses the right python interpreter):
catkin_install_python(PROGRAMS scripts/talker.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

> roscd myFirstPackage
> mkdir scripts
> cd scripts
> wget https://raw.github.com/ros/ros_tutorials/kinetic-devel/rospy_tutorials/001_talker_listener/talker.py
> chmod +x talker.py

Code explained:
1    #!/usr/bin/env python
-->  Every Python ROS Node will have this declaration at the top. The first line makes sure your script is executed as a Python script.

3    import rospy
--> Requirement for creating a ROS node.
4    from std_msgs.msg import String
--> ?

7    pub = rospy.Publisher('chatter', String, queue_size=10)
--> ?
8    rospy.init_node('talker', anonymous=True)
--> NOTE: the name must be a base name (talker) , i.e. it cannot contain any slashes "/".
--> anonymous = True ensures that your node has a unique name by adding random numbers to the end of NAME.
