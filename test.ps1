# Define the path of the file to be backed up
$fileToBackup = "C:\Automation\file.txt"

# Define the path where the backup will be saved with a timestamp
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupFileName = "file_backup_$timestamp.txt"
$backupPath = "C:\Automation\$backupFileName"

# Perform the backup immediately
Copy-Item -Path $fileToBackup -Destination $backupPath -Force

# -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Automation\test.ps1