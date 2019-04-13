CMAKE_MINIMUM_REQUIRED(VERSION 3.0.1)
PROJECT(mongoose-os-template)

IF(NOT MCU_Platform)
    MESSAGE("Please specify conifguration type MCU_Platform = ESP8266 | ESP32 | Windows")
    RETURN()
endif()

ADD_SUBDIRECTORY(src)
ADD_SUBDIRECTORY(tests)