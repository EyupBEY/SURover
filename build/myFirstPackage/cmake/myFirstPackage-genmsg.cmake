# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "myFirstPackage: 1 messages, 1 services")

set(MSG_I_FLAGS "-ImyFirstPackage:/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(myFirstPackage_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg" NAME_WE)
add_custom_target(_myFirstPackage_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "myFirstPackage" "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg" ""
)

get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv" NAME_WE)
add_custom_target(_myFirstPackage_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "myFirstPackage" "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/myFirstPackage
)

### Generating Services
_generate_srv_cpp(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/myFirstPackage
)

### Generating Module File
_generate_module_cpp(myFirstPackage
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/myFirstPackage
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(myFirstPackage_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(myFirstPackage_generate_messages myFirstPackage_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_cpp _myFirstPackage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_cpp _myFirstPackage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(myFirstPackage_gencpp)
add_dependencies(myFirstPackage_gencpp myFirstPackage_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS myFirstPackage_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/myFirstPackage
)

### Generating Services
_generate_srv_eus(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/myFirstPackage
)

### Generating Module File
_generate_module_eus(myFirstPackage
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/myFirstPackage
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(myFirstPackage_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(myFirstPackage_generate_messages myFirstPackage_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_eus _myFirstPackage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_eus _myFirstPackage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(myFirstPackage_geneus)
add_dependencies(myFirstPackage_geneus myFirstPackage_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS myFirstPackage_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/myFirstPackage
)

### Generating Services
_generate_srv_lisp(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/myFirstPackage
)

### Generating Module File
_generate_module_lisp(myFirstPackage
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/myFirstPackage
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(myFirstPackage_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(myFirstPackage_generate_messages myFirstPackage_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_lisp _myFirstPackage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_lisp _myFirstPackage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(myFirstPackage_genlisp)
add_dependencies(myFirstPackage_genlisp myFirstPackage_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS myFirstPackage_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/myFirstPackage
)

### Generating Services
_generate_srv_nodejs(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/myFirstPackage
)

### Generating Module File
_generate_module_nodejs(myFirstPackage
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/myFirstPackage
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(myFirstPackage_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(myFirstPackage_generate_messages myFirstPackage_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_nodejs _myFirstPackage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_nodejs _myFirstPackage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(myFirstPackage_gennodejs)
add_dependencies(myFirstPackage_gennodejs myFirstPackage_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS myFirstPackage_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/myFirstPackage
)

### Generating Services
_generate_srv_py(myFirstPackage
  "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/myFirstPackage
)

### Generating Module File
_generate_module_py(myFirstPackage
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/myFirstPackage
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(myFirstPackage_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(myFirstPackage_generate_messages myFirstPackage_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/msg/Num.msg" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_py _myFirstPackage_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/eyupbey/Desktop/SuRover/src/myFirstPackage/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(myFirstPackage_generate_messages_py _myFirstPackage_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(myFirstPackage_genpy)
add_dependencies(myFirstPackage_genpy myFirstPackage_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS myFirstPackage_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/myFirstPackage)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/myFirstPackage
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(myFirstPackage_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/myFirstPackage)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/myFirstPackage
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(myFirstPackage_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/myFirstPackage)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/myFirstPackage
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(myFirstPackage_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/myFirstPackage)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/myFirstPackage
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(myFirstPackage_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/myFirstPackage)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/myFirstPackage\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/myFirstPackage
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(myFirstPackage_generate_messages_py std_msgs_generate_messages_py)
endif()
