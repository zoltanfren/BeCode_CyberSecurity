function Get-MachineInfo {

    $computerName = $env:COMPUTERNAME
    $userName = $env:USERNAME

    $osInfo = Get-ComputerInfo
    $osName = $osInfo.OSName
    $osVersion = $osInfo.OSVersion

    $bootInfo = Get-CimInstance Win32_OperatingSystem
    $lastBoot = $bootInfo.LastBootUpTime

    Write-Host "Computer Name : $computerName"
    Write-Host "User          : $userName"
    Write-Host "OS            : $osName ($osVersion)"
    Write-Host "Last Boot     : $lastBoot"
}

function Test-ServiceStatus {
    param (
        [string]$ServiceName
    )

    try {
        $svc = Get-Service -Name $ServiceName -ErrorAction Stop

        # Get start mode (Automatic, Manual, Disabled)
        $wmiSvc = Get-CimInstance -ClassName Win32_Service -Filter "Name='$ServiceName'"

        if ($svc.Status -eq "Running") {
            return @{
                Name      = $ServiceName
                Status    = "Running"
                StartType = $wmiSvc.StartMode
            }
        }
        else {
            return @{
                Name      = $ServiceName
                Status    = "Stopped"
                StartType = $wmiSvc.StartMode
            }
        }
    }
    catch {
        return @{
            Name      = $ServiceName
            Status    = "Not Found"
            StartType = "Unknown"
        }
    }
}

function Get-EnabledUsers {

    $users = Get-LocalUser

	foreach ($user in $users) {
		
		
		Write-Host ("Name = $user.Name")
		
		$name = $user.Name
		$enabled = $user.Enabled
		$passwordlastset  = $user.PasswordLastSet
		
		

    if ($user.Enabled -and $user.PasswordLastSet -eq $null) {
        Write-Host ("{0,-15} {1} [WARN] No password ever set" -f $user.Name, $status) -ForegroundColor Yellow
    }
    else {
        Write-Host ("{0,-15} {1}" -f $user.Name, $status)
    }
}
}

function Get-RunningServices {
    param (
        [string]$Filter
    )

    $services = Get-Service | Where-Object { $_.Status -eq "Running" }

    if ($Filter) {
        $services = $services | Where-Object {
            $_.DisplayName -like "*$Filter*"
        }
    }

    $services | Select-Object Name, DisplayName, Status | Format-Table -AutoSize
}

function Get-RecentErrors {
    $startTime = (Get-Date).AddHours(-24)

    Get-WinEvent -FilterHashtable @{
        LogName   = 'System'
        StartTime = $startTime
        Level     = 2
    }
}

