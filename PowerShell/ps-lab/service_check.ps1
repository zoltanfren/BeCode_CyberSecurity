$services = @("WinDefend", "Spooler", "wuauserv", "Chrome")

Write-Host "Services:"

foreach ($svc in $services){
	
	$service = Get-Service -Name $svc -ErrorAction SilentlyContinue
	
	if ($service -eq $null){
		
		Write-Host "$svc not found" -ForegroundColor Red

	}
	else {
	
		Write-Host "$($service.name) is $($service.status)"
	}
}

