C:\esp\openocd-esp32\bin\openocd.exe -c "tcl_port disabled"  -s C:\esp\openocd-esp32\share\openocd\scripts -c "gdb_port 3333" -c "telnet_port 4444" -f board/esp-wroom-32.cfg