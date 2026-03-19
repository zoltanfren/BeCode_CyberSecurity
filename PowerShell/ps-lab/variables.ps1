$pc_name = $env:COMPUTERNAME
$port = 80
$is_server = $true
$services = @("WinDefend", "Spooler", "wuauserv")
$machine = @{
	Name = "ZolPC"
	IP = "192.168.1.1"
	OS = Windows11
}

Write-Host @"
PC = $pc_name
Port = $port
Server = $is_server
Services = $services
"@ -ForegroundColor Blue

Write-Host @"
Machine Name = $($machine.Name)
Machine IP = $($machine.IP)
Machine Port = $($machine.Port)
"@ -ForegroundColor Green