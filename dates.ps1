$date1 = Get-Date "2023-01-01"
$date2 = Get-Date "2023-12-31"

if ($date1 -lt $date2) {
    Write-Host "$date1 is earlier than $date2"
}
else {
    Write-Host "$date1 is the same as or later than $date2"
}


### Seperation

$startDate = Get-Date "2023-01-01"
$endDate = Get-Date "2023-12-31"
$timeSpan = $endDate - $startDate
Write-Host "The difference is: $($timeSpan.Days) days"