# Security settings template content
$securityTemplateContent = @"
[Version]
signature=`"`$CHICAGO`$`"
Revision=1

[System Access]
PasswordComplexity = 1
PasswordHistorySize = 5
ClearTextPassword = 0
"@
# Set password policies
net accounts /uniquepasswords:5
net accounts /maxpwage:90
net accounts /minpwage:30
net accounts /minpwlen:14

# Set account lockout policies
net accounts /lockoutthreshold:5
net accounts /lockoutduration:30
net accounts /lockoutwindow:30
# File path for the security template
$templateFilePath = "C:\Temp\SecurityPolicy.inf"

# Ensure the target directory exists
$directory = Split-Path -Path $templateFilePath -Parent
if (-not (Test-Path -Path $directory)) {
    New-Item -ItemType Directory -Path $directory | Out-Null
}

# Save the security template to a file
$securityTemplateContent | Out-File -FilePath $templateFilePath -Encoding Default

# Apply the security template
$seceditCmd = "secedit /configure /db secedit.sdb /cfg `"$templateFilePath`" /areas SECURITYPOLICY"
Invoke-Expression $seceditCmd

# Check for errors after applying the template
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error applying security policy. Check the log at %windir%\security\logs\scesrv.log for details."
} else {
    Write-Host "Security policy applied successfully."
}

# Set audit policies for specified categories
$auditCategories = @("System", "Logon/Logoff", "Object Access", "Privilege Use", "Detailed Tracking", "Policy Change", "Account Management", "DS Access", "Account Logon")
foreach ($category in $auditCategories) {
    $cmd = "auditpol /set /category:`"$category`" /success:enable /failure:enable"
    Invoke-Expression $cmd
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to set audit policy for category $category."
    } else {
        Write-Host "Audit policy set for category $category."
    }
}

# Clean up the security template file
Remove-Item -Path $templateFilePath -Force

# Optional: Load the Active Directory module if needed and available
if (Get-Module -ListAvailable -Name ActiveDirectory) {
    Import-Module ActiveDirectory
    Write-Host "Active Directory module loaded successfully."
} else {
    Write-Host "Active Directory module not available. Skipping."
}

Write-Host "Complete!"
