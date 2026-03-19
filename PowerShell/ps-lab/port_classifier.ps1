$ports = @(80, 443, 3389, 4444, 1337)
$riskyPorts = @(4444, 1337, 31337, 5555, 9001)

foreach ($port in $ports) {

    if ($port -in $riskyPorts) {
        Write-Host "[RISKY] Port $port" -ForegroundColor Red
    }
    else {
        Write-Host "[SAFE]  Port $port" -ForegroundColor Green
    }
}