# Get all drives that are of the FileSystem provider type

######
### With Pipes
######

Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
######
### Without Pipes
######

Write-Output "`n### SEPARATOR ###`n"

$drives = Get-PSDrive -PSProvider FileSystem

$formattedDiskInfo = @()

foreach ($drive in $drives) {
    $diskInfoString = [PSCustomObject]@{
        Name = $drive.Name
        Used = $drive.Used
        Free = $drive.Free
    }
    $formattedDiskInfo += $diskInfoString
}

$formattedDiskInfo
