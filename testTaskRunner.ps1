# Navigate to your local repository
$repoPath = "C:\Path\To\Your\Local\Repo"
Set-Location -Path $repoPath

# Pull the latest changes from Azure Repos
git pull

# Execute your PowerShell script
$scriptPath = Join-Path -Path $repoPath -ChildPath "YourScript.ps1"
& powershell.exe -File $scriptPath
