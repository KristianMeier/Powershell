### With Pipes ###

Get-ChildItem C:\Automation -Recurse |
Where-Object { $_.Length -gt 100 } |
Select-Object FullName, Length

### With Pipes and ForEach-Object###

Get-ChildItem C:\Automation -Recurse | 
Where-Object { $_.Length -gt 100 } |
ForEach-Object {
    [PSCustomObject]@{
        FullName = $_.FullName
        Length   = $_.Length
    }
}

Write-Output "`n### SEPARATOR ###`n"

### Without Pipes
$largeFiles = @()
$items = Get-ChildItem C:\Automation -Recurse -File
foreach ($item in $items) {
    if ($item.Length -gt 100) {
        $fileObject = [PSCustomObject]@{
            FullName = $item.FullName
            Length   = $item.Length
        }
        $largeFiles += $fileObject
    }
}

$largeFiles