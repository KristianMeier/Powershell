# PowerShell script to generate HTML with inline CSS styling
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
</style>
"@

$processesHtml =
Get-Process |
Select-Object -First 10 -Property Description, @{ Name="CPU"; Expression={"{0:N1}" -f$_.CPU} }, FileName | 
ConvertTo-Html -Head $css -PreContent "<h1>Process List</h1>" -Title "Process List"

$processesHtml | Out-File process.html