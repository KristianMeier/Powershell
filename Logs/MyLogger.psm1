function Write-Log {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message,

        [Parameter(Mandatory = $false)]
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO",

        [Parameter(Mandatory = $false)]
        [string]$LogPath = "C:\Automation\Logs\Log.log"
    )

    # Ensure the log directory exist
    $LogDir = Split-Path -Path $LogPath -Parent
    if (-not (Test-Path -Path $LogDir)) {
        New-Item -ItemType Directory -Path $LogDir | Out-Null
    }

    # Format the log entry
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp [$Level] $Message"

    # Write the log entry to the specified log file
    Add-Content -Path $LogPath -Value $logEntry
}

Export-ModuleMember -Function Write-Log