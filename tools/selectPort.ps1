Clear-Host
Write-Host "================ SELECT Port ================"
$ports = (Get-WMIObject Win32_SerialPort | % {$_.DeviceId}) + 
            (Get-Content tools/recentPortList.txt ) |
            % {$counter = 0}{$_;$counter++}|
            % {$_ +""}

for ( $index = 0; $index -lt $ports.count; $index++)
{
    "{0}: {1}" -f $index, $ports[$index]
}

Write-Host     
Write-Host "Q: Press 'Q' to quit."

$selection = Read-Host "Please make a selection"

if( $ports[ $selection] ) 
{
    Write-Host "Selected" $ports[ $selection]
    $selection=$ports[ $selection]
}
elseif ($selection -eq "q" -or $selection -eq "Q")
{
    return
}
else
{
    @($selection) + (Get-Content tools/recentPortList.txt) | Get-Unique | Set-Content tools/recentPortList.txt
}
$selection | Set-Content tools/selectedPort.txt