# Script to set Administrative Template settings via PowerShell with path checks

# Ensure running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run as Administrator"
    exit
}

# Function to check and create registry path if it doesn't exist
Function CheckAndCreatePath($Path) {
    If (-Not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
}

# Define registry paths and settings in a hashtable
$settings = @{
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" = @{
        "NoLockScreenCamera" = 1;
        "NoLockScreenSlideshow" = 1
    };
    "HKLM:\SOFTWARE\Policies\Microsoft\Speech\OnlineSpeechPrivacy" = @{
        "AllowOnlineSpeechPrivacy" = 0
    };
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" = @{
        "DisableSoftlanding" = 1
    };
    "HKLM:\SOFTWARE\Policies\Microsoft\Services\AdmPwd" = @{
        "AdmPwdEnabled" = 1;
        "PasswordComplexity" = 1;
        "PasswordLength" = 15;
        "PasswordAgeDays" = 30
    };
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers" = @{
        "PointAndPrint_RestrictDriverInstallationToAdministrators" = 1
    }
}

# Iterate over each path and setting
foreach ($path in $settings.Keys) {
    CheckAndCreatePath $path
    $settings[$path].Keys | ForEach-Object {
        $name = $_
        $value = $settings[$path][$name]
        Set-ItemProperty -Path $path -Name $name -Value $value -Type DWord
    }
}

Write-Host "Complete!"