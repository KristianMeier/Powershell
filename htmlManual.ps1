# Define CSS styles
$css = @"
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        table-layout: auto;
    }
    th, td { 
        border: 1px solid #ddd;
        text-align: left;
        padding: 8px;
    }
    th {
        background-color: #f2f2f2;
    }
    .low-cpu { 
        color: red; 
    }
</style>
"@

# Start building the HTML content
$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Process List</title>
    $css
</head>
<body>
    <h1>Process List</h1>
    <table>
        <tr>
            <th>Description</th>
            <th>CPU</th>
            <th>FileName</th>
        </tr>
"@

# Get the top 10 processes and append rows to the HTML content
Get-Process | Select-Object -First 10 -Property Description, CPU, FileName | Sort-Object CPU | ForEach-Object {
    $cpuStyle = if ($_.CPU -lt 5 -and $_.CPU -ne $null) { ' class="low-cpu"' } else { "" }
    $cpuValue = "{0:N1}" -f $_.CPU
    $htmlContent += @"
        <tr>
            <td>$($_.Description)</td>
            <td$cpuStyle>$cpuValue</td>
            <td>$($_.FileName)</td>
        </tr>
"@
}

# Close the HTML tags
$htmlContent += @"
    </table>
</body>
</html>
"@

# Write the HTML content to a file
$htmlContent | Out-File processManual.html
