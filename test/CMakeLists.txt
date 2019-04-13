CMAKE_MINIMUM_REQUIRED(VERSION 3.0.1)


SET(SOURCE_FILES tests.cpp)
SET(gtest_force_shared_crt ON)

INCLUDE_DIRECTORIES("gtest/googletest/include")
ADD_SUBDIRECTORY(gtest)

IF(${MCU_Platform} STREQUAL "Windows")
    ADD_EXECUTABLE(runUnitTests tests.cpp)
    TARGET_LINK_LIBRARIES(runUnitTests gtest gmock compile_local_sensor)
ENDIF()