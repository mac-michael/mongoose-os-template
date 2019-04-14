$path = "tools/selectedPort.txt"

if (Test-Path $path -PathType Leaf)
{
    $port = Get-Content $path
    Write-Host 'Using port ' + $port
    mos flash --port $port 2>&1 | %{ "$_" }
}
else
{
    Write-Host 'Port not selected - using default'
    mos flash 2>&1 | %{ "$_" }
}