Write-Host "Deploying scripts to D:\automation"
robocopy /MIR .\src\backup.7zip\*.ps1 D:\automation\backup
