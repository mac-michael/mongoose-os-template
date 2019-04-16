$path = Get-Location | Split-Path -leaf
$binFileName = "build/objs/" + $path + ".bin"
$params = "program_esp32 " + $binFileName + " 0x10000 reset exit"


Write-Host $params

openocd -s share/openocd/scripts -f interface/ftdi/esp32_devkitj_v1.cfg -f board/esp-wroom-32.cfg -c $params
exit $LASTEXITCODE 