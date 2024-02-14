# Check and Create the path if it doesn't exist for CloudContent
$cloudContentPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (-not (Test-Path $cloudContentPath)) {
    New-Item -Path $cloudContentPath -Force
}
# Now you can safely set item properties for CloudContent
Set-ItemProperty -Path $cloudContentPath -Name "DisableTailoredExperiencesWithDiagnosticData" -Value 1
Set-ItemProperty -Path $cloudContentPath -Name "DisableWindowsSpotlightFeatures" -Value 1
Set-ItemProperty -Path $cloudContentPath -Name "DisableSoftLanding" -Value 1
Set-ItemProperty -Path $cloudContentPath -Name "DisableWindowsSpotlightTasks" -Value 1

# Check and Create the path if it doesn't exist for Installer
$installerPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
if (-not (Test-Path $installerPath)) {
    New-Item -Path $installerPath -Force
}
# Now you can safely set item properties for Installer
Set-ItemProperty -Path $installerPath -Name "AlwaysInstallElevated" -Value 0

# Continue with the rest of your script...
# Screen Saver Configuration
$desktopPath = "HKCU:\Control Panel\Desktop"
if (-not (Test-Path $desktopPath)) {
    New-Item -Path $desktopPath -Force
}
Set-ItemProperty -Path $desktopPath -Name "SCRNSAVE.EXE" -Value "scrnsave.scr"
Set-ItemProperty -Path $desktopPath -Name "ScreenSaveActive" -Value "1"
Set-ItemProperty -Path $desktopPath -Name "ScreenSaverIsSecure" -Value "1"
Set-ItemProperty -Path $desktopPath -Name "ScreenSaveTimeOut" -Value "900"

# Disable Toast Notifications
$explorerAdvancedPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (-not (Test-Path $explorerAdvancedPath)) {
    New-Item -Path $explorerAdvancedPath -Force
}
Set-ItemProperty -Path $explorerAdvancedPath -Name "ToastEnabled" -Value 0

# Telemetry and Data Collection
$dataCollectionPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (-not (Test-Path $dataCollectionPath)) {
    New-Item -Path $dataCollectionPath -Force
}
Set-ItemProperty -Path $dataCollectionPath -Name "AllowTelemetry" -Value 0

# Attachment Manager
$attachmentsPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments"
if (-not (Test-Path $attachmentsPath)) {
    New-Item -Path $attachmentsPath -Force
}
Set-ItemProperty -Path $attachmentsPath -Name "SaveZoneInformation" -Value 0
Set-ItemProperty -Path $attachmentsPath -Name "ScanWithAntiVirus" -Value 1

# Windows Media Player Preferences
$mediaPlayerPreferencesPath = "HKCU:\Software\Microsoft\MediaPlayer\Preferences"
if (-not (Test-Path $mediaPlayerPreferencesPath)) {
    New-Item -Path $mediaPlayerPreferencesPath -Force
}
Set-ItemProperty -Path $mediaPlayerPreferencesPath -Name "AllowScreensaver" -Value 1
Set-ItemProperty -Path $mediaPlayerPreferencesPath -Name "DisableCodecDownload" -Value 1
Set-ItemProperty -Path $mediaPlayerPreferencesPath -Name "NoCDBurning" -Value 1
Set-ItemProperty -Path $mediaPlayerPreferencesPath -Name "NoCDInfo" -Value 1
Set-ItemProperty -Path $mediaPlayerPreferencesPath -Name "NoMusicInfo" -Value 1
Set-ItemProperty -Path $mediaPlayerPreferencesPath -Name "NoRadioPresets" -Value 1

# Explorer Sharing and Security Settings
$explorerPoliciesPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (-not (Test-Path $explorerPoliciesPath)) {
    New-Item -Path $explorerPoliciesPath -Force
}
Set-ItemProperty -Path $explorerPoliciesPath -Name "NoInPlaceSharing" -Value 1

# Ensure the script runs with feedback indicating completion
Write-Host "Complete!"
