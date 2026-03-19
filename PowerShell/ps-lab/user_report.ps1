$users = Get-LocalUser

foreach ($user in $users) {

    $status = if ($user.Enabled) { "[ENABLED]" } else { "[DISABLED]" }

    if ($user.Enabled -and $user.PasswordLastSet -eq $null) {
        Write-Host ("{0,-15} {1} [WARN] No password ever set" -f $user.Name, $status) -ForegroundColor Yellow
    }
    else {
        Write-Host ("{0,-15} {1}" -f $user.Name, $status)
    }
}