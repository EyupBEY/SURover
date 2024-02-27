# [Installing and Configuring Your ROS Environment](http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment)

## What is ROS
Set of software libraries that run on a linux system. Not an OS.

> Check the environment variables & versions
```
printenv | grep R
```
> Check whether or not we installed ros
```
roscore
```
> Sourcing Packages
```
source /opt/ros/<distro>/setup.bash
```
> [!IMPORTANT]
> Run on every new shell you open or after you build sth in order to have access to the ROS commands, unless you add this line to your .bashrc.

## Catkin - Create Workspace
> The new build system for ROS is "catkin", while "rosbuild" is the old
```
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
```
> it will create a CMakeLists.txt link it in your 'src' folder.
```
catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3
```
> Check whether it is properly overlayed
```
source devel/setup.bash
echo $ROS_PACKAGE_PATH
```

---

# [Navigating the ROS Filesystem](https://wiki.ros.org/ROS/Tutorials/NavigatingTheFilesystem)
```
sudo apt-get install ros-<distro>-ros-tutorials
```
* Packages: Packages are the software organization unit of ROS code. Each package can contain libraries, executables, scripts, or other artifacts.

* Manifests (package.xml): A manifest is a description of a package. It serves to define dependencies between packages and to capture meta information about the package like version, maintainer, license, etc...

## Filesystemtools
### Rospack
> Gives information about packages (i.e. roscpp)
```
rospack find [package_name]
```
### Roscd
> Changes directory (cd) directly to a package or a stack. (i.e. roscpp/cmake, roscpp, or log)
```
roscd <package-or-stack>[/subdir]
```
### Rosls
> It ls's directly in a package by name rather than by absolute path. (i.e. myfirstpackage)
```
rosls <package-or-stack>[/subdir]
```
> [!TIP]
>You can use TAB key twice to see currently installed packages
### See ROS package path
```
echo $ROS_PACKAGE_PATH
```

---

# [ROS Packages](https://wiki.ros.org/ROS/Tutorials/CreatingPackage)

## Trivial Workspace
* workspace_folder/        -- WORKSPACE
    * src/                   -- SOURCE SPACE
        * CMakeLists.txt       -- 'Toplevel' CMake file, provided by catkin
        * package_n/
            * CMakeLists.txt     -- CMakeLists.txt file for package_n
            * package.xml        -- Package manifest for package_n

## Creating Catkin Package
> We are now creating a package named myfirstpackage package which depends on std_msgs, rospy, and roscpp

> This will create a myfirstpackage folder which contains a package.xml and a CMakeLists.txt
```
cd src
catkin_create_pkg myfirstpackage std_msgs rospy roscpp
```
> [!WARNING]
> Package name should only contain lower case letters, digits, underscores, and dashes.
rev 1
> Builds any catkin projects found in the src folder(by default) in the workspace
```
cd ~/catkin_ws
catkin_make
```
or
```
catkin_make --source my_src
```

> To add the workspace to your ROS environment you need to source the generated setup file
```
. ~/catkin_ws/devel/setup.bash
```

## Dependencies
> To show the dependencies:
```
rospack depends1 myfirstpackage
```
or
```
roscd myfirstpackage
cat package.xml
```

> To show Independent Dependencies, in other words Dependencies's Dependencies
```
rospack depends myfirstpackage
```

## Customizing Package - package.xml
```xml
<description>The myfirstpackage package</description>
```
> Maintainer - Author(At least 1 required), email required
```xml
<maintainer email="user@todo.todo">user</maintainer>
```
> License Tags are: BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3
```xml
<license>BSD</license>
```
> Dependencies Tags: build_depend, buildtool_depend, exec_depend, test_depend.
```xml
<!-- We need dependencies to be available at both build and run time. -->

<!-- Use build_depend for packages you need at compile time: -->
<build_depend>genmsg</build_depend>
<!-- Use buildtool_depend for build tool packages: -->
<buildtool_depend>catkin</buildtool_depend>
<!-- Use exec_depend for packages you need at runtime: -->
<exec_depend>python-yaml</exec_depend>
<!-- Use test_depend for packages you need only for testing: -->
<test_depend>gtest</test_depend>
```

> Sample package.xml:
```xml
<?xml version="1.0"?>
<package format="2">
   <name>myfirstpackage</name>
   <version>0.1.0</version>
   <description>The myfirstpackage package</description>
 
   <maintainer email="emin.ozkanli@sabanciuniv.edu">Hamid Emin Ozkanli</maintainer>
   <license>BSD</license>
   <url type="website">https://github.com/EyupBEY/SuRover</url>
   <author email="hamideminozkanli@gmail.com">Hamid Emin Ozkanli</author>
 
   <buildtool_depend>catkin</buildtool_depend>
 
   <build_depend>roscpp</build_depend>
   <build_depend>rospy</build_depend>
   <build_depend>std_msgs</build_depend>
 
   <exec_depend>roscpp</exec_depend>
   <exec_depend>rospy</exec_depend>
   <exec_depend>std_msgs</exec_depend>
</package>
```

---

# [Building a ROS Package](https://wiki.ros.org/ROS/Tutorials/BuildingPackages)

---

# [ROS Nodes](https://wiki.ros.org/ROS/Tutorials/UnderstandingNodes)

## Graph Concepts
**Nodes:** A node is an executable that uses ROS to communicate with other nodes by ROS client library(rospy, and roscpp).<br>
**Messages:** ROS data type used when subscribing or publishing to a topic.<br>
**Topics:** Nodes can publish messages to a topic as well as subscribe to a topic to receive messages.<br>
**Master:** Name service for ROS (i.e. helps nodes find each other)<br>
**rosout:** ROS equivalent of stdout/stderr<br>
**roscore:** Master + rosout + parameter server (parameter server will be introduced later)

## Run first when using ROS
```
roscore
```
> [!TIP]
> If it doesn't work, it is probably because /.ros is owned by root:
> ``` sudo chown -R <your_username> ~/.ros ```

## rosnode
```
rosnode list
```
>**Output:** <br>
/rosout             -->Active nodes are listed
```
rosnode info /rosout
```

> Clean the rosnode list with:```rosnode cleanup```
To test that whether or not it's up:
```
rosnode ping my_turtle
```

## rosrun
Allows you to use the package name to directly run a node within a package
<br>
> rosrun [package_name] [node_name]
```
rosrun turtlesim turtlesim_node
```

> [!TIP]
> You can change the name, but first close the previous terminal: ```rosrun turtlesim turtlesim_node __name:=my_turtle```

---

# [ROS Topics](https://wiki.ros.org/ROS/Tutorials/UnderstandingTopics)

## Setup
```
roscore
```
```
rosrun turtlesim turtlesim_node
```
```
rosrun turtlesim turtle_teleop_key
```
> [!NOTE]
> Use arrow keys to move turtle, and make sure your typings recorded in the terminal

## ROS Topics
The turtlesim_node and the turtle_teleop_key node are communicating with each other over a ROS Topic.<br>
turtle_teleop_key is publishing the key strokes on a topic, while turtlesim subscribes to the same topic to receive the key strokes.

## Using rqt_graph
```
sudo apt-get install ros-<distro>-rqt
```
```
sudo apt-get install ros-<distro>-rqt-common-plugins
```
```
rosrun rqt_graph rqt_graph
```
> Uncheck the debug.
* The text abowed the arrow is TOPIC.
* The semi eliptics are NODEs.
    * Nodes are communicating via topic.

## rostopic
```
rostopic -h
```
or press <tab> to see sub-commands.
```
rostopic echo [topic]
```
To see the topics: ```rostopic list```
```
rostopic echo /turtle1/cmd_vel
```
> /turtle1/cmd_vel is a topic mentioned in rqt_graph

### rostopic list
```
rostopic list -h
```
To see verbose option: ```rostopic list -v```<br>
Publisher: turtle_teleop_key<br>
Subscriber: turtlesim_node

### rostopic type
Shows the type of the message
```
rostopic type [topic]
```
```
rostopic type /turtle1/cmd_vel
```
To see the details:```rosmsg show geometry_msgs/Twist```

### rostopic pub
Publishes data
```
rostopic pub [topic] [msg_type] [args]
```
```
rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, 1.8]'
```

-- | :-
-1                  | Means only publish one message and exit<br>
/turtle1/cmd_vel    | The name of the topic to publish<br>
geometry_msgs/Twist | Type of the message<br>
--                  | Tells the option parser that none of the following arguments is an option. This is required in cases where your arguments have a leading dash -, like negative numbers.

* The arguments are in YAML syntax(https://wiki.ros.org/ROS/YAMLCommandLine)
* Turtle has stopped moving why because we need 1 Hz to keep moving using -r:
    * ```rostopic pub /turtle1/cmd_vel geometry_msgs/Twist -r 1 -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, -1.8]'```
        * Press the refresh button in the upper-left in rqt_graph.
You can see the data published by our turtlesim:
```
rostopic echo /turtle1/pose
```
### rostopic hz
Reports the average rate at which data is published
```
rostopic hz [topic]
```
```
rostopic hz /turtle1/pose
```
```
rostopic type /turtle1/cmd_vel | rosmsg show
```

## rqt_plot
It displays a scrolling time plot of the data published on topics.
> [!Note]
> If you're using electric or earlier, rqt is not available. Use rxplot instead.
```
rosrun rqt_plot rqt_plot
```
> Type one of them to the Topic bar: /turtle1/pose/x or /turtle1/pose/y or /turtle1/pose/theta

---

# [ROS Services and Parameters](https://wiki.ros.org/ROS/Tutorials/UnderstandingServicesParams)

## rosservice
ROS Services are another way that nodes can communicate with each other.<br>
Services allow nodes to send a request and receive a response.<br><br>

To print information about active services:
```
rosservice list                   
```

To print service type:
```
rosservice type [service]
```
```
rosservice type /clear
```
> **std_srvs/Empty:** Means it is empty service. it takes no arguments (i.e. it sends no data when making a request and receives no data when receiving a response)
```
rosservice type /spawn | rossrv show
```
To create a new turtle at given location and orientation:
```
rosservice call /spawn 2 2 0.2 "optionalNameSection"
```
Call the service with the provided args:
```
rosservice call [service] [args]
```
```
rosservice call /clear
```
> It clears the turtlesim screen
> It has no arguments because /clear is type of empty

To find services by service type:
```
rosservice find
```

To print service ROSRPC uri:
```
rosservice uri
```

## rosparam
The Parameter Server can store: integers, floats, boolean, dictionaries, and lists.<br>
rosparam uses the YAML markup language for syntax:<br>
* 1 is an integer
* 1.0 is a float
* one is a string
* true is a boolean
* [1, 2, 3] is a list of integers
* {a: b, c: d} is a dictionary.

To list parameter names:
```
rosparam list
```

To set parameter:
```
rosparam set [param_name]
```
* ```rosparam set /turtlesim/background_r 150``` It sets red channel of the background color 150
To get parameter:
```
rosparam get [param_name]
```
* ```rosparam get /turtlesim/background_g```
* ```rosparam get /``` It shows the contents of the entire Parameter Server
>       rosdistro: 'noetic
>        '
>        roslaunch:
>        uris:
>            host_nxt__43407: http://nxt:43407/
>        rosversion: '1.15.5
>        '
>        run_id: 7ef687d8-9ab7-11ea-b692-fcaa1494dbf9
>        turtlesim:
>        background_b: 255
>        background_g: 86
>        background_r: 69

To dump the parameters to a file to use later:
```
rosparam dump [file_name] [namespace]
```
* ```rosparam dump params.yaml```

To load parameters from a file to our new workspace:
```
rosparam load [file_name] [namespace]
```
* ```rosparam load params.yaml copy_turtle```

To delete parameter:
```
rosparam delete
```
To make the changes affect:
```
rosservice call /clear
```

---

# [rqt_console and roslaunch](https://wiki.ros.org/ROS/Tutorials/UsingRqtconsoleRoslaunch)

## rqt_console and rqt_logger_level
ROS's logging framework to display output from nodes. rqt_logger_level allows us to change the verbosity level (DEBUG, WARN, INFO, and ERROR) of nodes as they run.
```
rosrun rqt_console rqt_console
```
```
rosrun rqt_logger_level rqt_logger_level
```

## roslaunch
```
cd ~/Desktop/SuRover
```
```
source devel/setup.bash
```
```
roscd myfirstpackage
```

To start nodes as defined in a launch file:
```
roslaunch [package] [filename.launch]
```
```
roscd myfirstpackage
```
```
mkdir launch
```
```
cd launch
```

Create a file named turtlemimic.launch, and insert the code below:
```xml
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
```

```
roslaunch myfirstpackage turtlemimic.launch
```
```
rostopic pub /turtlesim1/turtle1/cmd_vel geometry_msgs/Twist -r 1 -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, -1.8]'
```

Run belowed command and select Plugins > Introspection > Node Graph:
```
rqt
```
or
```
rqt_graph
```

---

# [rosed](https://wiki.ros.org/ROS/Tutorials/UsingRosEd)

Edit a file within a package by using the package name rather than having to type the entire path to the package.
```
rosed [package_name] [filename]
```
* ```rosed roscpp Logger.msg```
* ```rosed myfirstpackage turtlemimic.launch```

> [!Note]
> The default editor for rosed is vim. Thus, the abowed code probably won't work.<br>
> Edit ~/.bashrc file to include:<br>
> ```export EDITOR='nano -w'```
> or if you prefer emacs:
> ```export EDITOR='emacs -nw'```

To check:
```
echo $EDITOR
```

---

# [ROS msg and srv](https://wiki.ros.org/ROS/Tutorials/CreatingMsgAndSrv)

## msg (message)
A simpe text files that are used to generate source code for messages in different languages. They are stored in the msg directory of a package.<br>
Simple text files with a field type and field name per line.<br><br>

**Field Types:**<br>
* Header - contains a timestamp and coordinate frame information. You will frequently see the first line in a msg file have Header header.
* int8, int16, int32, int64 (plus uint*)
* float32, float64
* string
* time, duration
* other msg files
* variable-length array[] and fixed-length array[C]
```
roscd myfirstpackage
```
```
mkdir msg
```

Here is an example of a msg that uses a Header, a string primitive, and two other msgs:
```msg
    Header header
    string child_frame_id
    geometry_msgs/PoseWithCovariance pose
    geometry_msgs/TwistWithCovariance twist
    string first_name
    string last_name
    uint8 age
    uint32 score
```

Add belowed lines to package.xml because we need to make sure that the msg files are turned into source code for C++, Python, and other languages:
```xml
    <build_depend>message_generation</build_depend>
    <exec_depend>message_runtime</exec_depend>
```
* at build time, we need "message_generation",
* while at runtime, we only need "message_runtime"

Add the "message_generation" dependency to the "find_package" call which already exists in your myfirstpackage/CMakeLists.txt so that you can generate messages.

Modify the existing text to add message_generation before the closing parenthesis:
```txt
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
```

Now we are ready to generate source files from your msg definition.

To check:
``` 
rosmsg show [message type]
```
* ```rosmsg show myfirstpackage/Num```
<br>or
* ```rosmsg show Num```

## srv (service)
A file that describes a service, it is composed of: request & response.

They are stored in the srv directory.

request and a response parts are separated by a '---' line. Here is an example of a srv file(A and B are request, Sum is response):
```txt
    int64 A
    int64 B
    ---
    int64 Sum
```

```
roscd myfirstpackage
```
```
mkdir srv
```
Instead of creating a srv definition by hand we copy an existing from another package by using roscp:
```
roscp [package_name] [file_to_copy_path] [copy_path]
```
* ```roscp rospy_tutorials AddTwoInts.srv srv/AddTwoInts.srv```

Add this lines to package.xml because we need to make sure that the msg files are turned into source code for C++, Python, and other languages:
```xml
    <build_depend>message_generation</build_depend>
    <exec_depend>message_runtime</exec_depend>
```
* at build time, we need "message_generation",
* while at runtime, we only need "message_runtime"

Modify the existing text to add message_generation before the closing parenthesis:
```txt
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
```

To check:
```
rossrv show <service type>
```
* ```rossrv show myfirstpackage/AddTwoInts```

## Common step for msg and srv
Now that we have made some new messages we need to make our package again:

In your catkin workspace,
```
roscd myfirstpackage
```
```
cd ../..
```

To make (compile) a ROS package:
```
catkin_make
```
or use another alternative to make (compiles) a ROS package in an isolated manner while maintaining efficiency due to parallelisation:
```
catkin build
```
```
cd -
```

Any .msg file in the msg directory will generate code for use in all supported languages:
* The C++ message header file will be generated in ~/catkin_ws/devel/include/myfirstpackage/
* The Python script will be created in ~/catkin_ws/devel/lib/python2.7/dist-packages/myfirstpackage/msg
* The lisp file appears in ~/catkin_ws/devel/share/common-lisp/ros/myfirstpackage/msg/
Similarly, any .srv files in the srv directory will have generated code in supported languages:
* For C++, this will generate header files in the same directory as the message header files.
* For Python and Lisp, there will be an 'srv' folder beside the 'msg' folders.

---

# [Writing a Simple Publisher and Subscriber (Python)](https://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28python%29)
"Node" is the ROS term for an executable that is connected to the ROS network.

Here we'll create the publisher ("talker") node which will continually broadcast a message:

Add the following to your CMakeLists.txt(This makes sure the python script gets installed properly, and uses the right python interpreter):
```txt
catkin_install_python(PROGRAMS scripts/talker.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
```
```
roscd myfirstpackage
```
```
mkdir scripts
```
```
cd scripts
```
```
wget https://raw.github.com/ros/ros_tutorials/kinetic-devel/rospy_tutorials/001_talker_listener/talker.py
```
```
chmod +x talker.py
```

Python code explained:
```python
#!/usr/bin/env python
# Every Python ROS Node will have this declaration at the top. The first line makes sure your script is executed as a Python script.

import rospy
# Requirement for creating a ROS node.

from std_msgs.msg import String
# ?

pub = rospy.Publisher('chatter', String, queue_size=10)
# ?

rospy.init_node('talker', anonymous=True)
# NOTE: the name must be a base name (talker) , i.e. it cannot contain any slashes "/".
# anonymous = True ensures that your node has a unique name by adding random numbers to the end of NAME.

rate = rospy.Rate(10) # 10hz
# With the help of its method sleep(), it offers a convenient way for looping at the desired rate. With its argument of 10, we should expect to go through the loop 10 times per second (as long as our processing time does not exceed 1/10th of a second!)

while not rospy.is_shutdown():
    hello_str = "hello world %s" % rospy.get_time()
    rospy.loginfo(hello_str)
    pub.publish(hello_str)
    rate.sleep()
# This loop is a fairly standard rospy construct: checking the rospy.is_shutdown() flag and then doing work. You have to check is_shutdown() to check if your program should exit (e.g. if there is a Ctrl-C or otherwise).
# In this case, the "work" is a call to pub.publish(hello_str) that publishes a string to our chatter topic.
# The loop calls rate.sleep(), which sleeps just long enough to maintain the desired rate through the loop. Same as time.sleep()
# This loop also calls rospy.loginfo(str), which performs triple-duty:
#   The messages get printed to screen,
#   It gets written to the Node's log file
#   It gets written to rosout.
#       rosout is for debugging: you can pull up messages using rqt_console instead of having to find the console window with your Node's output.

std_msgs.msg.String is a very simple message type. Same as:
    msg = String()
    msg.data = str    
# or
    String(data=str)

try:
    talker()
except rospy.ROSInterruptException:
    pass
# In addition to the standard Python __main__ check, this catches a rospy.ROSInterruptException exception, which can be thrown by rospy.sleep() and rospy.Rate.sleep() methods when Ctrl-C is pressed or your Node is otherwise shutdown. The reason this exception is raised is so that you don't accidentally continue executing code after the sleep().
```

## Create Subscriber Node - A node to receive messages
> roscd myfirstpackage/scripts/
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
> roscd myfirstpackage
> cd ../..
> catkin_make

---

# [Examining the Simple Publisher and Subscriber](https://wiki.ros.org/ROS/Tutorials/ExaminingPublisherSubscriber)

## Running Publisher
> roscore
Source the setup after calling catkin_make or creating a new terminal.
> roscd myfirstpackage
> cd ../..
> source ./devel/setup.bash

> rosrun myfirstpackage talker      (C++)
> rosrun myfirstpackage talker.py   (Python) 

## Running Subscriber
> rosrun myfirstpackage listener     (C++)
> rosrun myfirstpackage listener.py  (Python)

---

# [Writing a Simple Service and Client (Python)](https://wiki.ros.org/ROS/Tutorials/WritingServiceClient%28python%29)

## Writing a Service Node
Here we'll create the service ("add_two_ints_server") node which will receive two ints and return the sum.
Do the things mentioned in one of the previous sections (srv (service) - A file that describes a service, it is composed of: request & response. They are stored in the srv directory.)

> roscd myfirstpackage
> touch scripts/add_two_ints_server.py

#!/usr/bin/env python
from __future__ import print_function
from myfirstpackage.srv import AddTwoInts,AddTwoIntsResponse
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
> roscd myfirstpackage
> touch scripts/add_two_ints_client.py

--> For clients you don't have to call init_node(). Wait_for_service must be called. This is a convenience method that blocks until the service named add_two_ints is available.

#!/usr/bin/env python
from __future__ import print_function
import sys
import rospy
from myfirstpackage.srv import *
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

> roscd myfirstpackage
> cd ../..
> catkin_make

---

# [Examining the Simple Service and Client](https://wiki.ros.org/ROS/Tutorials/ExaminingServiceClient)
```
roscore
```
## Running the service
> For C++
```
rosrun myfirstpackage add_two_ints_server
```

> For Python
```
rosrun myfirstpackage add_two_ints_server.py
```
## Running the Client
> For C++
```
rosrun myfirstpackage add_two_ints_client 1 3
```

> For Python
```
rosrun myfirstpackage add_two_ints_client.py 1 3
```