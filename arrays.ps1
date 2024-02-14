$myArray = @('apple', 'banana', 'cherry')
Write-Host "The first element is: $($myArray[0])"

$myArray[1] = 'blueberry'
Write-Host "The modified array contains: $myArray"

$myArray += 'date'
Write-Host "The array now contains: $myArray"

$myArray = @(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
$evenNumbers = $myArray | Where-Object { $_ % 2 -eq 0 }
Write-Host "Even numbers: $evenNumbers"