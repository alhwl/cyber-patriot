# Script to apply Administrative Template settings with path checks

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

# Define registry settings
$settings = @(
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections";
        Name = "NC_AllowNetBridge_NLA";
        Type = "DWord";
        Value = 1
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections";
        Name = "NC_ShowSharedAccessUI";
        Type = "DWord";
        Value = 1
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections";
        Name = "NC_StdDomainUserSetLocation";
        Type = "DWord";
        Value = 1
    },
    # Add more settings as necessary, following the same structure.
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths";
        Name = "\\*\NETLOGON";
        Type = "String";
        Value = "RequireMutualAuthentication=1, RequireIntegrity=1"
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths";
        Name = "\\*\SYSVOL";
        Type = "String";
        Value = "RequireMutualAuthentication=1, RequireIntegrity=1"
    }
    # Continue adding other settings following the format above.
)

# Apply each setting
foreach ($setting in $settings) {
    CheckAndCreatePath -Path $setting.Path
    Set-ItemProperty -Path $setting.Path -Name $setting.Name -Value $setting.Value -Type $setting.Type
}

Write-Host "Complete!"
