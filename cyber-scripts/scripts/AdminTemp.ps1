# PowerShell script for setting Administrative Templates (User) configurations

# Function to check and create the registry path if it does not exist
Function CheckAndCreatePath($Path) {
    If (-Not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
}

# User Configuration Settings
$userSettings = @(
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop";
        Name = "ScreenSaveActive";
        Type = "String";
        Value = "1";
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop";
        Name = "ScreenSaverIsSecure";
        Type = "String";
        Value = "1";
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop";
        Name = "ScreenSaveTimeOut";
        Type = "String";
        Value = "900";
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer";
        Name = "NoToastApplicationNotificationOnLockScreen";
        Type = "DWord";
        Value = 1;
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings";
        Name = "DisableHelpItem";
        Type = "DWord";
        Value = 1;
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\CloudContent";
        Name = "DisableWindowsConsumerFeatures";
        Type = "DWord";
        Value = 1;
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\Network Sharing";
        Name = "NoInplaceSharing";
        Type = "DWord";
        Value = 1;
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\Windows\Installer";
        Name = "AlwaysInstallElevated";
        Type = "DWord";
        Value = 0;
    },
    @{
        Path = "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer";
        Name = "PreventCodecDownload";
        Type = "DWord";
        Value = 1;
    }
    # Additional settings can be added here
)

# Applying the configurations
foreach ($setting in $userSettings) {
    CheckAndCreatePath -Path $setting.Path
    Set-ItemProperty -Path $setting.Path -Name $setting.Name -Value $setting.Value -Type $setting.Type
}

Write-Host "complete!"
