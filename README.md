# Installing and Configuring Your ROS Environment
http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment

## What is ROS
Set of software libraries that run on a linux system. Not an OS.

## To check the environment variables & versions
```
printenv | grep R
```
## To check whether or not we installed ros
> roscore

## Sourcing Packages
> source /opt/ros/<distro>/setup.bash               i.e. place <distro> as noetic
*Run this command on every new shell you open to have access to the ROS commands, unless you add this line to your .bashrc.
*Allows you to install several ROS distributions (e.g. indigo and kinetic) on the same computer and switch between them.

## Create ROS Workspace using Catkin - The new build system for ROS is "catkin", while "rosbuild" is the old
> mkdir -p ~/catkin_ws/src
> cd ~/catkin_ws/
> catkin_make
it will create a CMakeLists.txt link in your 'src' folder.
> catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3

## Check whether it is properly overlayed
>source devel/setup.bash
>echo $ROS_PACKAGE_PATH
-------------------------------------------------------------------------------------------
# https://wiki.ros.org/ROS/Tutorials/NavigatingTheFilesystem
> sudo apt-get install ros-<distro>-ros-tutorials

## Packages: Packages are the software organization unit of ROS code. Each package can contain libraries, executables, scripts, or other artifacts.

## Manifests (package.xml): A manifest is a description of a package. It serves to define dependencies between packages and to capture meta information about the package like version, maintainer, license, etc...

## Filesystemtools
### Rospack - Gives information about packages
> rospack find [package_name]
    > rospack roscpp
### Roscd - Changes directory (cd) directly to a package or a stack.
> roscd <package-or-stack>[/subdir]
    > roscd roscpp
    > roscd roscpp/cmake
> pwd
#### ROS programs log, history
> roscd log
### Rosls - It ls's directly in a package by name rather than by absolute path.
> rosls <package-or-stack>[/subdir]
    > rosls roscpp_tutorials
    > rosls <<< now push the TAB key twice >>>    To see currently installed packages

## See ROS package path
> echo $ROS_PACKAGE_PATH
-------------------------------------------------------------------------------------------
# https://wiki.ros.org/ROS/Tutorials/CreatingPackage

## Standalone
my_package/
  CMakeLists.txt
  package.xml

## Trivial Workspace(recommended)
workspace_folder/        -- WORKSPACE
  src/                   -- SOURCE SPACE
    CMakeLists.txt       -- 'Toplevel' CMake file, provided by catkin
    package_1/
      CMakeLists.txt     -- CMakeLists.txt file for package_1
      package.xml        -- Package manifest for package_1
    ...
    package_n/
      CMakeLists.txt     -- CMakeLists.txt file for package_n
      package.xml        -- Package manifest for package_n

## Creating Catkin Package - A package named beginner_tutorials package which depends on std_msgs, rospy, and roscpp
> cd src
WARNING: Package name "myFirstPackage" does not follow the naming conventions. It should start with a lower case letter and only contain lower case letters, digits, underscores, and dashes.
> catkin_create_pkg myFirstPackage std_msgs rospy roscpp
It will create a myFirstPackage folder which contains a package.xml and a CMakeLists.txt

> cd ~/catkin_ws

> catkin_make           build any catkin projects found in the src folder(by default) in the workspace
> catkin_make --source my_src

> . ~/catkin_ws/devel/setup.bash                To add the workspace to your ROS environment you need to source the generated setup file


## Dependencies
> rospack depends1 beginner_tutorials        Shows the dependencies

> roscd beginner_tutorials
> cat package.xml                            This shows as well

> rospack depends1 rospy                     Independent Dependencies - Dpendencies' Dependency

> rospack depends beginner_tutorials         Shows literally all dependencies

## Customizing Package

You can change the line inside of the file named package.xml
<description>The beginner_tutorials package</description>

Maintainer - Author(At least 1 required), email required
> <maintainer email="user@todo.todo">user</maintainer>

License Tags - BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3
<license>BSD</license>

Dependencies Tags: build_depend, buildtool_depend, exec_depend, test_depend.
<!-- Use build_depend for packages you need at compile time: -->
<!--   <build_depend>genmsg</build_depend> -->
<!-- Use buildtool_depend for build tool packages: -->
<!--   <buildtool_depend>catkin</buildtool_depend> -->
<!-- Use exec_depend for packages you need at runtime: -->
<!--   <exec_depend>python-yaml</exec_depend> -->
<!-- Use test_depend for packages you need only for testing: -->
<!--   <test_depend>gtest</test_depend> -->

<buildtool_depend>catkin</buildtool_depend>

<!-- We need dependencies to be available at both build and run time. -->
<build_depend>roscpp</build_depend>
<build_depend>rospy</build_depend>
<build_depend>std_msgs</build_depend>
<exec_depend>roscpp</exec_depend>
<exec_depend>rospy</exec_depend>
<exec_depend>std_msgs</exec_depend>

Sample package.xml:
<?xml version="1.0"?>
<package format="2">
   <name>beginner_tutorials</name>
   <version>0.1.0</version>
   <description>The beginner_tutorials package</description>
 
   <maintainer email="you@yourdomain.tld">Your Name</maintainer>
   <license>BSD</license>
   <url type="website">http://wiki.ros.org/beginner_tutorials</url>
   <author email="you@yourdomain.tld">Jane Doe</author>
 
   <buildtool_depend>catkin</buildtool_depend>
 
   <build_depend>roscpp</build_depend>
   <build_depend>rospy</build_depend>
   <build_depend>std_msgs</build_depend>
 
   <exec_depend>roscpp</exec_depend>
   <exec_depend>rospy</exec_depend>
   <exec_depend>std_msgs</exec_depend>
</package>

-------------------------------------------------------------------------------------------
# https://wiki.ros.org/ROS/Tutorials/BuildingPackages
-------------------------------------------------------------------------------------------

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

9     rate = rospy.Rate(10) # 10hz
--> With the help of its method sleep(), it offers a convenient way for looping at the desired rate. With its argument of 10, we should expect to go through the loop 10 times per second (as long as our processing time does not exceed 1/10th of a second!)

10     while not rospy.is_shutdown():
11         hello_str = "hello world %s" % rospy.get_time()
12         rospy.loginfo(hello_str)
13         pub.publish(hello_str)
14         rate.sleep()
--> This loop is a fairly standard rospy construct: checking the rospy.is_shutdown() flag and then doing work. You have to check is_shutdown() to check if your program should exit (e.g. if there is a Ctrl-C or otherwise).
--> In this case, the "work" is a call to pub.publish(hello_str) that publishes a string to our chatter topic.
--> The loop calls rate.sleep(), which sleeps just long enough to maintain the desired rate through the loop. Same as time.sleep()
--> This loop also calls rospy.loginfo(str), which performs triple-duty:
        The messages get printed to screen,
        It gets written to the Node's log file
        It gets written to rosout.
            rosout is for debugging: you can pull up messages using rqt_console instead of having to find the console window with your Node's output.

std_msgs.msg.String is a very simple message type. Same as:
    msg = String()
    msg.data = str    
  or
    String(data=str)

17     try:
18         talker()
19     except rospy.ROSInterruptException:
20         pass
--> In addition to the standard Python __main__ check, this catches a rospy.ROSInterruptException exception, which can be thrown by rospy.sleep() and rospy.Rate.sleep() methods when Ctrl-C is pressed or your Node is otherwise shutdown. The reason this exception is raised is so that you don't accidentally continue executing code after the sleep().

## Create Subscriber Node - A node to receive messages
> roscd myFirstPackage/scripts/
> wget https://raw.github.com/ros/ros_tutorials/kinetic-devel/rospy_tutorials/001_talker_listener/listener.py
> chmod +x listener.py

Edit the catkin_install_python() call in your CMakeLists.txt:
    catkin_install_python(PROGRAMS scripts/talker.py scripts/listener.py
        DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
    )

15     rospy.init_node('listener', anonymous=True)
17     rospy.Subscriber("chatter", String, callback)
19     # spin() simply keeps python from exiting until this node is stopped
20     rospy.spin()
--> This declares that your node subscribes to the chatter topic which is of type std_msgs.msgs.String. When new messages are received, callback is invoked(called) with the message as the first argument.
--> We also changed up the call to rospy.init_node() somewhat.
--> We've added the anonymous=True keyword argument. ROS requires that each node have a unique name. If a node with the same name comes up, it bumps the previous one. This is so that malfunctioning nodes can easily be kicked off the network. The anonymous=True flag tells rospy to generate a unique name for the node so that you can have multiple listener.py nodes run easily.
--> Finally, rospy.spin() simply keeps your node from exiting until the node has been shutdown. Unlike roscpp, rospy.spin() does not affect the subscriber callback functions, as those have their own threads.

Build the node, yes, even for python.
> roscd myFirstPackage
> cd ../..
> catkin_make
--------------------------------------------------------------------------------------------

# https://wiki.ros.org/ROS/Tutorials/ExaminingPublisherSubscriber

## Running Publisher
> roscore
Source the setup after calling catkin_make or creating a new terminal.
> roscd myFirstPackage
> cd ../..
> source ./devel/setup.bash

> rosrun beginner_tutorials talker      (C++)
> rosrun beginner_tutorials talker.py   (Python) 

## Running Subscriber
> rosrun beginner_tutorials listener     (C++)
> rosrun beginner_tutorials listener.py  (Python)
--------------------------------------------------------------------------------------------

# https://wiki.ros.org/ROS/Tutorials/WritingServiceClient%28python%29

## Writing a Service Node
Here we'll create the service ("add_two_ints_server") node which will receive two ints and return the sum.
Do the things mentioned in one of the previous sections (srv (service) - A file that describes a service, it is composed of: request & response. They are stored in the srv directory.)

> roscd myFirstPackage
> touch scripts/add_two_ints_server.py

#!/usr/bin/env python
from __future__ import print_function
from beginner_tutorials.srv import AddTwoInts,AddTwoIntsResponse
import rospy
def handle_add_two_ints(req):
    print("Returning [%s + %s = %s]"%(req.a, req.b, (req.a + req.b)))
    return AddTwoIntsResponse(req.a + req.b)
def add_two_ints_server():
    rospy.init_node('add_two_ints_server')
    s = rospy.Service('add_two_ints', AddTwoInts, handle_add_two_ints)
    print("Ready to add two ints.")
    rospy.spin()
if __name__ == "__main__":
    add_two_ints_server()

12     s = rospy.Service('add_two_ints', AddTwoInts, handle_add_two_ints)
--> This declares a new service named add_two_ints with the AddTwoInts service type. All requests are passed to handle_add_two_ints function. handle_add_two_ints is called with instances of AddTwoIntsRequest and returns instances of AddTwoIntsResponse.

> chmod +x scripts/add_two_ints_server.py

Add/Manipulate the following to CMAkeLists.txt in order to ensure the python script gets installed properly, and uses the right python interpreter:
    catkin_install_python(PROGRAMS scripts/add_two_ints_server.py
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
    )

## Writing a Client Node
> roscd myFirstPackage
> touch scripts/add_two_ints_client.py

--> For clients you don't have to call init_node(). Wait_for_service must be called. This is a convenience method that blocks until the service named add_two_ints is available.

#!/usr/bin/env python
from __future__ import print_function
import sys
import rospy
from beginner_tutorials.srv import *
def add_two_ints_client(x, y):
    rospy.wait_for_service('add_two_ints')
    try:

        add_two_ints = rospy.ServiceProxy('add_two_ints', AddTwoInts)
--> Next we create a handle(hizmet) for calling the service.

        resp1 = add_two_ints(x, y)
        return resp1.sum
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)
-->  The return value is an AddTwoIntsResponse object. If the call fails, a rospy.ServiceException may be thrown, so you should setup the appropriate try/except block.

def usage():
    return "%s [x y]"%sys.argv[0]
if __name__ == "__main__":
    if len(sys.argv) == 3:
        x = int(sys.argv[1])
        y = int(sys.argv[2])
    else:
        print(usage())
        sys.exit(1)
    print("Requesting %s+%s"%(x, y))
    print("%s + %s = %s"%(x, y, add_two_ints_client(x, y)))

> chmod +x scripts/add_two_ints_client.py

Add/Modify CMakeLists.txt:
catkin_install_python(PROGRAMS scripts/add_two_ints_client.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

> roscd myFirstPackage
> cd ../..
> catkin_make
--------------------------------------------------------------------------------------------

# https://wiki.ros.org/ROS/Tutorials/ExaminingServiceClient

## Running the service
> roscore
> rosrun myFirstPackage add_two_ints_server     (C++)
> rosrun myFirstPackage add_two_ints_server.py  (Python)

## Running the Client

> roscore
> rosrun myFirstPackage add_two_ints_client 1 3     (C++)
> rosrun myFirstPackage add_two_ints_client.py 1 3  (Python) 