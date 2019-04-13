CMAKE_MINIMUM_REQUIRED(VERSION 3.0.1)

# Download and unpack googletest at configure time
configure_file(CMakeLists.txt.in gtest/CMakeLists.txt)
execute_process(COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/tests/gtest" )
execute_process(COMMAND "${CMAKE_COMMAND}" --build .
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/tests/gtest" )
#
## Prevent GoogleTest from overriding our compiler/linker options
## when building with Visual Studio
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
#
## Add googletest directly to our build. This adds
## the following targets: gtest, gtest_main, gmock
## and gmock_main
add_subdirectory("${CMAKE_BINARY_DIR}/tests/googletest-src"
        "${CMAKE_BINARY_DIR}/tests/googletest-build")

# The gtest/gmock targets carry header search path
# dependencies automatically when using CMake 2.8.11 or
# later. Otherwise we have to add them here ourselves.
if(CMAKE_VERSION VERSION_LESS 2.8.11)
    include_directories("${gtest_SOURCE_DIR}/include"
            "${gmock_SOURCE_DIR}/include")
endif()

# Now simply link your own targets against gtest, gmock,
# etc. as appropriate

SET(SOURCE_FILES tests.cpp)

IF(${MCU_Platform} STREQUAL "Windows")
    ADD_EXECUTABLE(runUnitTests tests.cpp)
    TARGET_LINK_LIBRARIES(runUnitTests gtest gmock compile_local_sensor)
ENDIF()