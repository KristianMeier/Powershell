function New-EmailReport {
    param(
        [Parameter(Mandatory=$true)]
        [System.Collections.ArrayList]$servers
    )

    # Define CSS styles directly within the HTML to ensure compatibility across email clients
    $css = @"
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 20px;
        }
        table {
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .highlight {
            color: blue;
        }
    </style>
"@

    # Generate table rows
    $tableRows = $servers | Sort-Object CPU | ForEach-Object {
        $cpuStyle = if ($_.CPU -lt 5 -and $_.CPU -ne $null) { 'highlight' } else { "" }
        $cpuValue = if ($_.CPU -ne $null) { "{0:N1}" -f $_.CPU } else { "N/A" }
        @"
        <tr>
            <td>$($_.Name)</td>
            <td>$($_.Status)</td>
            <td class='$cpuStyle'>$cpuValue</td>
        </tr>
"@
    }

    $tableheaders =@"
        <tr>
            <td>test</td>
            <td>test</td>
            <td>test</td>
        </tr>
"@
    }

    # Construct HTML content
    $htmlContent = @"
    <!DOCTYPE html>
    <html>
    <head>
        $css
    </head>
    <body>
        <h4>Server Status Report</h4>
        <table>
            $tableHeaders
            $tableRows
        </table>
    </body>
    </html>
"@

    # Return HTML content
    return $htmlContent
}