param (
    [string]$OutputPath = "$env:USERPROFILE\ps-lab"
)

function Display-Header{
	Write-Host @"
=======================
System Audit Script
=======================
Shows various information about the system:
System identity, user accounts, running services, network connections,
recent security events, persistent locations

By Zoltan Frenyo - 18th of March 2026
=======================
"@
}

function Get-MachineInfo {
    Write-Host "[*] Collecting system identity..."

    try {
        $osInfo = Get-ComputerInfo -ErrorAction Stop
        $bootInfo = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop

        $result = [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            CurrentUser  = $env:USERNAME
            OSName       = $osInfo.OSName
            OSVersion    = $osInfo.OSVersion
            LastBoot     = $bootInfo.LastBootUpTime
        }

        Write-Host "[OK] Machine info collected."
        return $result
    }
    catch {
        Write-Host "[ERROR] Failed to collect machine info: $($_.Exception.Message)"

        return [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            CurrentUser  = $env:USERNAME
            OSName       = "Unknown"
            OSVersion    = "Unknown"
            LastBoot     = "Unknown"
        }
    }
}

function Get-UserAccounts{
	Write-Host "[*] Collecting user accounts..."

    try {
        $users = Get-LocalUser -ErrorAction Stop
        $account_count = 0
        $warning_count = 0

        $result = foreach ($user in $users) {
            $account_count += 1

            if ($user.Enabled -and $null -eq $user.PasswordLastSet) {
                $warning = "[WARN] No password ever set"
                $warning_count += 1
            }
            else {
                $warning = ""
            }

            [PSCustomObject]@{
                Name            = $user.Name
                Enabled         = $user.Enabled
                PasswordLastSet = $user.PasswordLastSet
                Warning         = $warning
            }
        }

        Write-Host "[OK] Found $account_count accounts. $warning_count warning(s)."
        return $result
    }
    catch {
        Write-Host "[ERROR] Failed to collect user accounts: $($_.Exception.Message)"
        return @()
    }
}

function Get-RunningServices {
    Write-Host "[*] Collecting running services..."

    try {
        $services = Get-Service -ErrorAction Stop |
                    Where-Object { $_.Status -eq "Running" } |
                    Sort-Object Name

        Write-Host "[OK] Found $($services.Count) running services."
        return $services
    }
    catch {
        Write-Host "[ERROR] Failed to collect services: $($_.Exception.Message)"
        return @()
    }
}

function Get-NetworkConnections {
    Write-Host "[*] Collecting network connections..."

    try {
        $suspiciousPorts = @(4444, 1337, 31337, 5555, 9001)

        $connections = Get-NetTCPConnection -State Established -ErrorAction Stop

        $result = foreach ($conn in $connections) {

            # Try to resolve process name
            try {
                $process = Get-Process -Id $conn.OwningProcess -ErrorAction Stop
                $processName = $process.ProcessName
            }
            catch {
                $processName = "Unknown"
            }

            [PSCustomObject]@{
                LocalAddress  = $conn.LocalAddress
                LocalPort     = $conn.LocalPort
                RemoteAddress = $conn.RemoteAddress
                RemotePort    = $conn.RemotePort
                ProcessName   = $processName
                Warning       = if ($conn.RemotePort -in $suspiciousPorts) {
                    "[WARN] Suspicious port"
                }
                else {
                    ""
                }
            }
        }

        Write-Host "[OK] Found $($result.Count) established connections."
        return $result
    }
    catch {
        Write-Host "[ERROR] Failed to collect network connections: $($_.Exception.Message)"
        return @()
    }
}


function Get-RecentSecurityEvents {
    Write-Host "[*] Collecting recent Security events..."

    try {
        $events = Get-WinEvent -LogName Security -MaxEvents 20 -ErrorAction Stop

        $result = foreach ($event in $events) {
            $shortMessage = if ($null -ne $event.Message) {
                if ($event.Message.Length -gt 100) {
                    $event.Message.Substring(0, 100)
                }
                else {
                    $event.Message
                }
            }
            else {
                ""
            }

            [PSCustomObject]@{
                TimeCreated = $event.TimeCreated
                EventID     = $event.Id
                Message     = $shortMessage
            }
        }

        Write-Host "[OK] Found $($result.Count) Security events."
        return $result
    }
    catch {
        Write-Host "[ERROR] Failed to collect Security events: $($_.Exception.Message)"
        return @()
    }
}

function Get-PersistenceLocations {
    Write-Host "[*] Collecting persistence locations..."

    $paths = @(
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
    )

    $result = foreach ($path in $paths) {
        try {
            $item = Get-ItemProperty -Path $path -ErrorAction Stop

            foreach ($property in $item.PSObject.Properties) {
                if ($property.Name -notin @('PSPath','PSParentPath','PSChildName','PSDrive','PSProvider')) {
                    [PSCustomObject]@{
                        RegistryPath = $path
                        Name         = $property.Name
                        Value        = $property.Value
                    }
                }
            }
        }
        catch {
            [PSCustomObject]@{
                RegistryPath = $path
                Name         = "[ERROR]"
                Value        = $_.Exception.Message
            }
        }
    }

    Write-Host "[OK] Checked $($paths.Count) persistence location(s)."
    return $result
}


Display-Header
$system_identity = Get-MachineInfo
$user_accounts = Get-UserAccounts
$running_services = Get-RunningServices
$network_connections = Get-NetworkConnections
$security_events = Get-RecentSecurityEvents
$persistence_locations = Get-PersistenceLocations

#WRITE TO FILE
$computer = $env:COMPUTERNAME
$date     = Get-Date -Format "yyyy-MM-dd"
$fileName = "audit_${computer}_${date}.txt"
$path = Join-Path $OutputPath $fileName

try {
    if (-not (Test-Path $OutputPath)) {
        New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
    }

    $report = @"
==================================================
SYSTEM AUDIT REPORT
==================================================
Computer Name : $env:COMPUTERNAME
Current User  : $env:USERNAME
Generated On  : $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

--------------------------------------------------
SECTION 1 - MACHINE INFO
--------------------------------------------------

$($system_identity | Format-List | Out-String)

--------------------------------------------------
SECTION 2 - USER ACCOUNTS
--------------------------------------------------

$($user_accounts | Format-Table Name, Enabled, PasswordLastSet, Warning -AutoSize | Out-String)

--------------------------------------------------
SECTION 3 - RUNNING SERVICES
--------------------------------------------------

Total running services: $($running_services.Count)

$($running_services | Select-Object Name, DisplayName, Status | Format-Table -AutoSize | Out-String)

--------------------------------------------------
SECTION 4 - NETWORK CONNECTIONS
--------------------------------------------------

Total connections: $($network_connections.Count)

$($network_connections | Format-Table LocalAddress, LocalPort, RemoteAddress, RemotePort, ProcessName, Warning -AutoSize | Out-String)

--------------------------------------------------
SECTION 5 - RECENT SECURITY EVENTS
--------------------------------------------------

Total events: $($security_events.Count)

$($security_events | Format-Table TimeCreated, EventID, Message -AutoSize | Out-String)

--------------------------------------------------
SECTION 6 - PERSISTENCE LOCATIONS
--------------------------------------------------

$($persistence_locations | Format-Table RegistryPath, Name, Value -AutoSize | Out-String)

==================================================
END OF REPORT
==================================================
"@

    Set-Content -Path $path -Value $report -ErrorAction Stop
    Write-Host "[OK] Report saved to $path"
}
catch {
    Write-Host "[ERROR] Failed to write report: $($_.Exception.Message)"
}

Write-Host "All checks complete."