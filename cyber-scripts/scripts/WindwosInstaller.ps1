# PowerShell script to configure Windows Installer and other settings
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run as Administrator"
    Exit
}

Function CheckAndCreatePath($Path) {
    If (-Not (Test-Path $Path)) {
        New-Item -Path $Path -ItemType "Directory" -Force | Out-Null
    }
}

$settings = @(
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer";
        Name = "DisableUserInstalls";
        Type = "DWord";
        Value = 1; # Disabled
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer";
        Name = "AlwaysInstallElevated";
        Type = "DWord";
        Value = 0; # Disabled
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer";
        Name = "SafeForScripting";
        Type = "DWord";
        Value = 0; # Disabled
    }
    # Ensure no trailing comma is left here
)

foreach ($setting in $settings) {
    CheckAndCreatePath -Path $setting.Path
    Set-ItemProperty -Path $setting.Path -Name $setting.Name -Value $setting.Value -Type $setting.Type
}

Write-Host "Complete!"
