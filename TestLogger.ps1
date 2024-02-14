# Import the module
Import-Module "C:\Automation\Logs\MyLogger.psm1"

Write-Log -Message "This is an informational message" -Level INFO
Write-Log -Message "This is a warning message" -Level WARNING -LogPath "C:\Automation\Logs\SpecialPath.log"
Write-Log -Message "This is an error message" -Level ERROR  