# Git Ignore
/folder/ignoredfile.txt --> Ignores specified file in the root directory
ignoresAllFilesOrFoldersStartingWithThisText*
*.md --> Ignores all the files ends with .md
!README.md --> Doesn't let the abowed code ignores README.md

# Temel Linux Komutları
https://www.tjhsst.edu/~dhyatt/superap/unixcmd.html


# Update/Upload code to Github
Click Source Control(CTRL+SHIFT+G)
Enter a messege - Mandatory
Click Commit
-------------------------------------------------------------------------------------------
# http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment

## What is ROS
Set of software libraries that run on a linux system. Not an OS.

## To check the environment variables & versions
> printenv | grep R

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