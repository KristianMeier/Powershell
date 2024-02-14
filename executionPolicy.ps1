Set-ExecutionPolicy Restricted

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "You are not running PowerShell as an Administrator."
}
else { Write-Host "You are" }