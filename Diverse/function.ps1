function Add-Numbers {
    param(
        $Number1 = 1,
        $Number2
    )
    return $Number1 + $Number2
}

$result = Add-Numbers -Number1 5 -Number2 10
Write-Host "The result is: $result"

$result = Add-Numbers -Number2 10
Write-Host "The result is: $result"
