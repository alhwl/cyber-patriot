# PowerShell Script to Disable Specified Windows Services

# Define a list of service names to disable
$servicesToDisable = @(
    'BTAGService',    # Bluetooth Audio Gateway Service
    'bthserv',        # Bluetooth Support Service
    'Browser',        # Computer Browser
    'MapsBroker',     # Downloaded Maps Manager
    'lfsvc',          # Geolocation Service
    'IISADMIN',       # IIS Admin Service
    'irmon',          # Infrared monitor service
    'SharedAccess',   # Internet Connection Sharing (ICS)
    'lltdsvc',        # Link-Layer Topology Discovery Mapper
    'LxssManager',    # LxssManager
    'FTPSVC',         # Microsoft FTP Service
    'MSiSCSI',        # Microsoft iSCSI Initiator Service
    'sshd',           # OpenSSH SSH Server
    'PNRPsvc',        # Peer Name Resolution Protocol
    'p2psvc',         # Peer Networking Grouping
    'p2pimsvc',       # Peer Networking Identity Manager
    'PNRPAutoReg',    # PNRP Machine Name Publication Service
    'Spooler',        # Print Spooler
    'wercplsupport',  # Problem Reports and Solutions Control Panel Support
    'RasAuto',        # Remote Access Auto Connection Manager
    'SessionEnv',     # Remote Desktop Configuration
    'TermService',    # Remote Desktop Services
    'UmRdpService',   # Remote Desktop Services UserMode Port Redirector
    'RpcLocator',     # Remote Procedure Call (RPC) Locator
    'RemoteRegistry', # Remote Registry
    'RemoteAccess',   # Routing and Remote Access
    'LanmanServer',   # Server
    'simptcp',        # Simple TCP/IP Services
    'SNMP',           # SNMP Service
    'sacsvr',         # Special Administration Console Helper
    'SSDPSRV',        # SSDP Discovery
    'upnphost',       # UPnP Device Host
    'WMSvc',          # Web Management Service
    'WerSvc',         # Windows Error Reporting Service
    'Wecsvc',         # Windows Event Collector
    'WMPNetworkSvc',  # Windows Media Player Network Sharing Service
    'icssvc',         # Windows Mobile Hotspot Service
    'WpnService',     # Windows Push Notifications System Service
    'PushToInstall',  # Windows PushToInstall Service
    'WinRM',          # Windows Remote Management (WS-Management)
    'W3SVC',          # World Wide Web Publishing Service
    'XboxGipSvc',     # Xbox Accessory Management Service
    'XblAuthManager', # Xbox Live Auth Manager
    'XblGameSave',    # Xbox Live Game Save
    'XboxNetApiSvc'   # Xbox Live Networking Service
)

# Loop through each service and disable it
foreach ($service in $servicesToDisable) {
    try {
        $svc = Get-Service -Name $service -ErrorAction Stop
        Write-Output "Disabling $service..."
        Set-Service -Name $service -StartupType Disabled -ErrorAction Stop
        # Stop the service if it is running
        if ($svc.Status -eq 'Running') {
            Stop-Service -Name $service -Force -ErrorAction Stop
        }
    } catch {
        Write-Output "$service service not found or cannot be disabled."
    }
}

Write-Host "Complete!"
