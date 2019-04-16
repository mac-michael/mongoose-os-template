for %%a in ("%cd%") do set "CurDir=%%~na" 

echo For example: %CurDir%

openocd -s share/openocd/scripts -f interface/ftdi/esp32_devkitj_v1.cfg -f board/esp-wroom-32.cfg -c "program_esp32 build/objs/%CurDir%.bin 0x10000 reset exit"