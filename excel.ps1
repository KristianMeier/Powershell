# Create a new Excel instance
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true

# Add a new workbook and select the first worksheet
$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)

# Loop 10 times to fill random cells
1..10 | ForEach-Object {
    # Generate random row and column numbers
    $row = Get-Random -Minimum 1 -Maximum 26
    $column = Get-Random -Minimum 1 -Maximum 26
    
    # Select the cell and set its background color to black
    $cell = $worksheet.Cells.Item($row, $column)
    $cell.Interior.Color = [System.Drawing.Color]::Black.ToArgb()
}
