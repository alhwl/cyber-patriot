# PowerShell script to manage user accounts based on 'admin.txt' and 'users.txt'

# Function to ensure a user exists
function Ensure-UserExists {
    param (
        [string]$username,
        [string]$userType
    )
    $userExists = Get-LocalUser | Where-Object { $_.Name -eq $username } | Select-Object -ExpandProperty Name

    if (-not $userExists) {
        # User does not exist, attempt to create
        try {
            $password = Read-Host "Enter password for $username" -AsSecureString
            New-LocalUser -Name $username -Password $password -FullName "$username" -Description "$userType user"
            Write-Host "User $username created as $userType."
        }
        catch {
            Write-Error "Failed to create user $username. Error: $_"
        }
    }
}

# Function to ensure a user is removed if not in the list
function Ensure-UserRemoved {
    param (
        [string]$username,
        [string[]]$adminList,
        [string[]]$userList
    )
    if ($username -notin $adminList -and $username -notin $userList) {
        # User is not in the list, attempt to remove
        try {
            Remove-LocalUser -Name $username
            Write-Host "User $username removed."
        }
        catch {
            Write-Error "Failed to remove user $username. Error: $_"
        }
    }
}

# Function to remove unauthorized admins
function Remove-UnauthorizedAdmins {
    param (
        [string[]]$adminList
    )
    $allAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name

    foreach ($admin in $allAdmins) {
        # Extract username from domain\username format
        $username = $admin -replace '.*\\'
        if ($username -notin $adminList) {
            try {
                Remove-LocalUser -Name $username
                Write-Host "Unauthorized admin $username removed."
            }
            catch {
                Write-Error "Failed to remove unauthorized admin $username. Error: $_"
            }
        }
    }
}

# Read users from files
$adminUsers = Get-Content -Path 'admin.txt'
$userUsers = Get-Content -Path 'users.txt'

# Ensure all admin users exist
foreach ($admin in $adminUsers) {
    Ensure-UserExists -username $admin -userType "Admin"
}

# Ensure all regular users exist
foreach ($user in $userUsers) {
    Ensure-UserExists -username $user -userType "User"
}

# Get all local users
$allLocalUsers = Get-LocalUser | Select-Object -ExpandProperty Name

# Remove users not in either list
foreach ($localUser in $allLocalUsers) {
    Ensure-UserRemoved -username $localUser -adminList $adminUsers -userList $userUsers
}

# Remove unauthorized administrators
Remove-UnauthorizedAdmins -adminList $adminUsers

Write-Host "Complete!"
