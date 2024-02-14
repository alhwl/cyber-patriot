# PowerShell script to apply various administrative template settings
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run as Administrator"
    Exit
}

Function CheckAndCreatePath($Path) {
    If (-Not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
}

# Example settings
$settings = @(
    # Delivery Optimization
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization";
        Name = "DODownloadMode";
        Type = "DWord";
        Value = 0; # Assuming 0 disables 'Enabled: Internet', adjust as necessary
    },
    # Event Log Service - Application
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application";
        Name = "Retention";
        Type = "String";
        Value = "0";
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application";
        Name = "MaxSize";
        Type = "DWord";
        Value = 32768; # 32 MB
    }
)

foreach ($setting in $settings) {
    CheckAndCreatePath -Path $setting.Path
    Set-ItemProperty -Path $setting.Path -Name $setting.Name -Value $setting.Value -Type $setting.Type
}

Write-Host "Complete!"
