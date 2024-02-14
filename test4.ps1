Import-Module ./EmailReportModule/EmailReportModule.psm1

$servers = @(
    @{ Name = "Server1"; Status = "Online"; CPU = 2.5 },
    @{ Name = "Server2"; Status = "Online"; CPU = 7.3 },
    @{ Name = "Server3"; Status = "Offline"; CPU = $null },
    @{ Name = "Server1"; Status = "Online"; CPU = 2 },
    @{ Name = "Server2"; Status = "Online"; CPU = 4 },
    @{ Name = "Server3"; Status = "Offline"; CPU = 8 }
)

$keys = $servers[0].Keys

$allKeys = @()
foreach ($key in $keys) {
    $allKeys += $key
}

$allKeys
$keys
