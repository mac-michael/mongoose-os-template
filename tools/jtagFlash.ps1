$path = Get-Location | Split-Path -leaf
$elfFileName = "build/objs/" + $path + ".elf"
$params = "program_esp32 " + $elfFileName + " 0x10000 reset exit"

Write-Host $params

openocd -s share/openocd/scripts -f interface/ftdi/esp32_devkitj_v1.cfg -f board/esp-wroom-32.cfg -c $params
exit $LASTEXITCODE 