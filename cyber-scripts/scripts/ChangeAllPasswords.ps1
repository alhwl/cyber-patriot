
# PowerShell script to change all user account passwords

$NewPassword = ConvertTo-SecureString "ThisP@ssw0rdisG00d123" -AsPlainText -Force

Get-LocalUser | Where-Object { $_.Enabled -eq $true } | ForEach-Object {
    try {
        $_ | Set-LocalUser -Password $NewPassword
        Write-Host "Password changed for user: $($_.Name)"
    } catch {
        Write-Error "Failed to change password for user: $($_.Name). Error: $_"
    }
}

Write-Host "Complete!"