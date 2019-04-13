CMAKE_MINIMUM_REQUIRED(VERSION 3.0.1)
SET(CMAKE_CXX_STANDARD 11)            # Enable c++11 standard

SET(TOOLCHAIN C:/SysGCC/esp8266/bin/)
SET(TOOLCHAIN_ESP32 C:/Program\ Files/Espressif/ESP-IDF\ Tools/tools/bin)
SET(RTO_SDK C:/SysGCC/esp8266/esp8266-bsp/RTOS-SDK/)
SET(RTO_ESP32 C:/esp/ESP31_RTOS_SDK)

IF(${MCU_Platform} STREQUAL "ESP8266")
    MESSAGE("Using extensa ESP8266 compiler")

    set(CMAKE_SYSTEM_NAME Linux)
    ADD_COMPILE_DEFINITIONS(CS_PLATFORM=CS_P_ESP8266)
    SET(CMAKE_C_COMPILER "${TOOLCHAIN}/xtensa-lx106-elf-gcc.exe")
    SET(CMAKE_CXX_COMPILER "${TOOLCHAIN}/xtensa-lx106-elf-g++.exe")

ELSEIF(${MCU_Platform} STREQUAL "ESP32")
    MESSAGE("Using extensa ESP32 compiler")

    set(CMAKE_SYSTEM_NAME Linux)
    ADD_COMPILE_DEFINITIONS(CS_PLATFORM=CS_P_ESP32)
    ADD_COMPILE_DEFINITIONS(LWIP_TIMEVAL_PRIVATE=0)
    SET(CMAKE_C_COMPILER "${TOOLCHAIN_ESP32}/xtensa-esp32-elf-gcc.exe")
    SET(CMAKE_CXX_COMPILER "${TOOLCHAIN_ESP32}/xtensa-esp32-elf-g++.exe")
elseif(${MCU_Platform} STREQUAL "Windows")
    MESSAGE("Using VS C++ compiler")

    SET(CMAKE_SYSTEM_NAME Windows)

    ADD_COMPILE_DEFINITIONS(CS_PLATFORM=CS_P_WINDOWS)
    ADD_COMPILE_DEFINITIONS(_MSC_VER=1916)
endif()

INCLUDE_DIRECTORIES("C:/mos/git_sources/mongoose-os/fw/include")
INCLUDE_DIRECTORIES("C:/mos/git_sources/mongoose-os/frozen")
INCLUDE_DIRECTORIES("C:/mos/git_sources/mongoose-os")
INCLUDE_DIRECTORIES("C:/mos/git_sources/mongoose-os/fw/platforms/esp8266/src")
INCLUDE_DIRECTORIES("C:/mos/git_sources/mongoose-os/fw/platforms/esp32/src")
INCLUDE_DIRECTORIES("C:/mos/git_sources/libs/mongoose/include")

IF(${MCU_Platform} STREQUAL "ESP8266" OR ${MCU_Platform} STREQUAL "ESP8266")
    INCLUDE_DIRECTORIES("${RTO_SDK}/include")
    INCLUDE_DIRECTORIES("${RTO_SDK}/include/lwip")
    INCLUDE_DIRECTORIES("${RTO_SDK}/include/espressif")
    INCLUDE_DIRECTORIES("${RTO_SDK}/include/lwip/ipv4")
    INCLUDE_DIRECTORIES("${RTO_SDK}/include/lwip/ipv6")
ELSEIF(${MCU_Platform} STREQUAL "ESP32")
    INCLUDE_DIRECTORIES("${RTO_ESP32}/include")
    INCLUDE_DIRECTORIES("${RTO_ESP32}/include/esp32")
    INCLUDE_DIRECTORIES("${RTO_ESP32}/third_party/include")
    INCLUDE_DIRECTORIES("${RTO_ESP32}/third_party/include/lwip")
    INCLUDE_DIRECTORIES("${RTO_ESP32}/third_party/include/lwip/port")
    INCLUDE_DIRECTORIES("${RTO_ESP32}/extra_include")
    INCLUDE_DIRECTORIES("C:/esp/esp-idf/components/vfs/include")
endif()
#INCLUDE_DIRECTORIES("C:/SysGCC/esp8266/xtensa-lx106-elf/sys-include")
#INCLUDE_DIRECTORIES("C:/SysGCC/esp8266/esp8266-bsp/RTOS-SDK/include/espressif")

#INCLUDE_DIRECTORIES("C:/Program Files (x86)/Windows Kits/10/Include/10.0.10150.0/ucrt")
#INCLUDE_DIRECTORIES("C:/Program Files (x86)/Microsoft Visual Studio 14.0/vc/include")

INCLUDE_DIRECTORIES("../include")
INCLUDE_DIRECTORIES("../build/gen")


SET(SOURCE_FILES main.cpp utils.c Module.cpp ../include/Module.h)

ADD_LIBRARY(compile_local_sensor ${SOURCE_FILES})
IF(${MCU_Platform} STREQUAL "ESP8266")
    SET_TARGET_PROPERTIES(compile_local_sensor PROPERTIES COMPILE_FLAGS -Wno-literal-suffix)
ELSEIF(${MCU_Platform} STREQUAL "ESP32")
    SET_TARGET_PROPERTIES(compile_local_sensor PROPERTIES COMPILE_FLAGS -Wno-literal-suffix)
ENDIF()

IF(${MCU_Platform} STREQUAL "ESP8266")
ADD_CUSTOM_TARGET( mos_build_sensor DEPENDS ${SOURCE_FILES} )
ADD_CUSTOM_COMMAND(
        TARGET mos_build_sensor
#        COMMAND powershell "mos build --local --platform esp8266 --verbose --repo C:/mos/git_sources/mongoose-os --libs-update-interval 24h --no-libs-update true --build-parallelism 8 --skip-clean-libs true --no-platform-check true --libs-dir c:/mos/git_sources/libs --lib veml6040:C:/mos/sensors/VEML6040 --lib veml6075:C:/mos/sensors/VEML6075 --lib debugger:C:/mos/sensors/debugger --lib debugger:C:/mos/sensors/debugger --lib debugger:C:/mos/sensors/debugger --lib as3935:C:/mos/sensors/as3935 --lib wifi-watchdog:C:/mos/sensors/wifi-watchdog 2>&1 | Foreach-Object {$$_ -replace '/c/mos/', 'c:/mos/'}; exit $$LastExitCode"
        COMMAND powershell "mos build --local --platform esp8266 --verbose 2>&1 | Foreach-Object {$$_ -replace '/c/mos/', 'c:/mos/'}; exit $$LastExitCode"
        DEPENDS ${SOURCE_FILES}
        WORKING_DIRECTORY ../..
        COMMENT "compiling using mos..."
)
elseIF(${MCU_Platform} STREQUAL "ESP32")
    ADD_CUSTOM_TARGET( mos_build_sensor DEPENDS ${SOURCE_FILES} )
    ADD_CUSTOM_COMMAND(
            TARGET mos_build_sensor
            COMMAND powershell "mos build --local --platform esp32 --verbose 2>&1 | Foreach-Object {$$_ -replace '/c/mos/', 'c:/mos/'}; exit $$LastExitCode"
            DEPENDS ${SOURCE_FILES}
            WORKING_DIRECTORY ../..
            COMMENT "compiling using mos..."
    )
endif()