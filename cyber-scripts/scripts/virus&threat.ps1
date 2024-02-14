# PowerShell Script to Configure Windows Defender for Maximum Security

# Ensure the script is running with administrative privileges
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Please run this script as an Administrator!"
    break
}

# Enable Real-Time Protection
Set-MpPreference -DisableRealtimeMonitoring $false

# Enable Cloud-Delivered Protection
Set-MpPreference -MAPSReporting Advanced

# Enable Automatic Sample Submission
Set-MpPreference -SubmitSamplesConsent SendSafeSamples

# Enable Potentially Unwanted Application (PUA) Protection
Set-MpPreference -PUAProtection 1

# Enable Network Protection to prevent online threats
Set-MpPreference -EnableNetworkProtection Enabled

# Set high threat level default actions
Set-MpPreference -HighThreatDefaultAction Quarantine -Force

# Set severe threat level default actions
Set-MpPreference -SevereThreatDefaultAction Quarantine -Force

Write-Host "Complete!"