# PowerShell Script to Configure Windows Defender Firewall Settings

# Ensure the script is run with Administrator privileges
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "You must run PowerShell with administrator privileges."
    Exit
}

# Domain Profile Settings
Set-NetFirewallProfile -Profile Domain -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen False -LogFileName "%SystemRoot%\System32\logfiles\firewall\domainfw.log" -LogMaxSizeKilobytes 16384 -LogAllowed True -LogBlocked True

# Private Profile Settings
Set-NetFirewallProfile -Profile Private -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen False -LogFileName "%SystemRoot%\System32\logfiles\firewall\privatefw.log" -LogMaxSizeKilobytes 16384 -LogAllowed True -LogBlocked True

# Public Profile Settings
Set-NetFirewallProfile -Profile Public -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Allow -NotifyOnListen False -LogFileName "%SystemRoot%\System32\logfiles\firewall\publicfw.log" -LogMaxSizeKilobytes 16384 -LogAllowed True -LogBlocked True

# Additional Public Profile Settings
Set-NetFirewallProfile -Profile Public -AllowLocalFirewallRules False -AllowLocalIPsecRules False

Write-Host "Complete!"