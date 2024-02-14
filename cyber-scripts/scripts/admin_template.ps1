# Administrative Templates

# Ensure the CloudContent path exists before setting its properties
$cloudContentPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (-not (Test-Path $cloudContentPath)) {
    New-Item -Path $cloudContentPath -Force
}
Set-ItemProperty -Path $cloudContentPath -Name "DisableOnlineTips" -Value 1

# Personalization settings
$personalizationPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
if (-not (Test-Path $personalizationPath)) {
    New-Item -Path $personalizationPath -Force
}
Set-ItemProperty -Path $personalizationPath -Name "NoLockScreenSlideshow" -Value 1
Set-ItemProperty -Path $personalizationPath -Name "NoChangingLockScreen" -Value 1
Set-ItemProperty -Path $personalizationPath -Name "NoChangingStartMenu" -Value 1
Set-ItemProperty -Path $personalizationPath -Name "NoLockScreenCamera" -Value 1

# Speech recognition settings
$speechPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Speech"
if (-not (Test-Path $speechPath)) {
    New-Item -Path $speechPath -Force
}
Set-ItemProperty -Path $speechPath -Name "AllowOnlineSpeechRecognition" -Value 0

# Handwriting settings
$handwritingPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Handwriting"
if (-not (Test-Path $handwritingPath)) {
    New-Item -Path $handwritingPath -Force
}
Set-ItemProperty -Path $handwritingPath -Name "DisableLearning" -Value 1
Set-ItemProperty -Path $handwritingPath -Name "DisableLanguagePackCleanup" -Value 0

# Local Administrator Password Solution (LAPS) settings
$lapsPath = "HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd"
if (-not (Test-Path $lapsPath)) {
    New-Item -Path $lapsPath -Force
}
Set-ItemProperty -Path $lapsPath -Name "PwdExpirationProtectionEnabled" -Value 1
Set-ItemProperty -Path $lapsPath -Name "EnableLocalAdminPasswordManagement" -Value 1
Set-ItemProperty -Path $lapsPath -Name "PasswordComplexity" -Value 1
Set-ItemProperty -Path $lapsPath -Name "PasswordLength" -Value 15
Set-ItemProperty -Path $lapsPath -Name "PasswordAge" -Value 30

# User Accounts settings
# Assuming the Explorer path already exists as it's common, but you may add a check if required

# Network Configuration
# Placeholder for network configuration settings

Write-Host "Complete!"
