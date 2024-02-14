# PowerShell Script to Configure User Rights Assignments

# Define the path for the security template
$templatePath = "C:\SecurityTemplate.inf"

# Create the security template content
$templateContent = @"
[Unicode]
Unicode=yes
[Version]
signature="$CHICAGO$"
Revision=1
[Privilege Rights]
; Set 'Access this computer from the network' to 'Administrators, Remote Desktop Users'
SeNetworkLogonRight = *S-1-5-32-544,*S-1-5-32-555
; Deny 'Access this computer from the network' for 'Guests, Local account'
SeDenyNetworkLogonRight = *S-1-5-32-546,*S-1-5-113
; Other rights can be added here following the same pattern

"@

# Write the security template content to the file
$templateContent | Out-File -FilePath $templatePath -Encoding Unicode -Force

# Apply the security template to the local security policy
secedit /configure /db secedit.sdb /cfg $templatePath /areas USER_RIGHTS

# Output the status
Write-Host "Complete!"
