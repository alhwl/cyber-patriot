# PowerShell Script to Configure Security Policies - Comprehensive Version with Corrections

# Ensure running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run PowerShell as an Administrator."
    Exit
}

# Function to safely set registry values, creating path if it doesn't exist
Function SafeSet-ItemProperty {
    param([string]$Path, [string]$Name, $Value)
    
    if (-Not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value
}

# Accounts Policies
# Disable Administrator Account
Rename-LocalUser -Name "Administrator" -NewName "NewAdminName" # Specify the new name
Disable-LocalUser -Name "NewAdminName"

# Block Microsoft Accounts
SafeSet-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "NoConnectedUser" -Value 3

# Disable Guest Account
Rename-LocalUser -Name "Guest" -NewName "NewGuestName" # Specify the new name
Disable-LocalUser -Name "NewGuestName"

# Limit local account use of blank passwords to console logon only
SafeSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LimitBlankPasswordUse" -Value 1

# Correct AuditPol Usage - Example for setting audit policy for Account Logon events
auditpol /set /subcategory:"Logon" /success:enable /failure:enable

# Devices: Prevent users from installing printer drivers
SafeSet-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers" -Name "DisablePrinterDriverInstallation" -Value 1

# Domain Member Policies - Continuing with domain member policies
SafeSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "RequireSignOrSeal" -Value 1
SafeSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "SealSecureChannel" -Value 1
SafeSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "SignSecureChannel" -Value 1
SafeSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "DisablePasswordChange" -Value 0
SafeSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "MaximumPasswordAge" -Value 30
SafeSet-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" -Name "RequireStrongKey" -Value 1

# Interactive Logon Policies
SafeSet-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableCAD" -Value 0

# Network Security Policies - Kerberos encryption types
SafeSet-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" -Name "SupportedEncryptionTypes" -Value 2147483640

# User Account Control Policies - Ensuring UAC is configured properly
SafeSet-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "FilterAdministratorToken" -Value 1

# Note: Replace any placeholders like "NewAdminName" and "NewGuestName" with actual values. Always test the script in a non-production environment first.

Write-Host "Complete!"
