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






# http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment

## To check the environment variables & versions
> printenv | grep R

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
