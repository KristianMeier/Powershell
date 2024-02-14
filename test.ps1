Import-Module ./EmailReportModule/EmailReportModule.psm1 -Force

$servers = @(
    @{ Name = "Server1"; Status = "Online"; CPU = 2.5 },
    @{ Name = "Server2"; Status = "Online"; CPU = 7.3 },
    @{ Name = "Server3"; Status = "Offline"; CPU = $null },
    @{ Name = "Server1"; Status = "Online"; CPU = 2 },
    @{ Name = "Server2"; Status = "Online"; CPU = 4 },
    @{ Name = "Server3"; Status = "Offline"; CPU = 8.1 }
)

$timestamp = Get-Date -Format "mmss"

$htmlReport = New-EmailReport -servers $servers

# Output to HTML file
$htmlReport | Out-File "ServerStatusReport_$timestamp.html"