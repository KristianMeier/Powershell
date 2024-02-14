Import-Module "C:\Automation\Logs\MyLogger.psm1"

### Explanation
# $_ refers normally to the object in the pipeline.
# In a catch-block it refes the the "exception object".
# It desciribes what went wrong in the try block.

try {
    Get-Content "C:\NonExistentFile.txt" -ErrorAction Stop
}
catch {
    Write-Log "An error occurred: $_"
}
finally {
    Write-Log -Message "Script Over"
}

###

try {
    # Outer try block
    # Code that might throw an exception
}
catch {
    # Outer catch block
    try {
        # Inner try block to handle the exception
    }
    catch {
        # Inner catch block
    }
}

###

try {
    # Code that might trigger an exception
}
catch [System.UnauthorizedAccessException] {
    # Handle unauthorized access exception
}
catch [System.IO.IOException] {
    # Handle IO exceptions
}
catch {
    # Handle any other exceptions not previously caught
}