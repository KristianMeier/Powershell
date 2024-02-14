$names = @('Alice', 'Bob', 'Charlie')
foreach ($name in $names) {
    Write-Host "Hello, $name!"
}

for ($i = 0; $i -lt 5; $i++) {
    Write-Host "Iteration number: $i"
}

$count = 1
while ($count -le 5) {
    Write-Host "Count is: $count"
    $count++
}

$numbers = 1..10
foreach ($number in $numbers) {
    if ($number -eq 5) {
        Write-Host "Breaking out of the loop at number: $number"
        break
    }
    Write-Host "Number: $number"
}