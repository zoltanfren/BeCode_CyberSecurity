try {
    $securityEvents = Get-EventLog -LogName "Security" -Newest 5 -ErrorAction Stop
    Write-Host "[OK] Read the last 5 entries from the Security event log"
}
catch {
    Write-Host "[ERROR] Read the last 5 entries from the Security event log - $($_.Exception.Message)"
}

try {
    $fakeLogEvents = Get-EventLog -LogName "FakeLog" -Newest 5 -ErrorAction Stop
    Write-Host "[OK] Read the last 5 entries from a log that does not exist (FakeLog)"
}
catch {
    Write-Host "[ERROR] Read the last 5 entries from a log that does not exist (FakeLog) - $($_.Exception.Message)"
}

try {
    $process = Get-Process -Name "this_process_does_not_exist" -ErrorAction Stop
    Write-Host "[OK] Get a process named this_process_does_not_exist"
}
catch {
    Write-Host "[ERROR] Get a process named this_process_does_not_exist - $($_.Exception.Message)"
}

Write-Host "All checks complete."