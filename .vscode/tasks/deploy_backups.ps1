Write-Host "Deploying backup scripts to D:\automation\backup"
robocopy '.\src\backup' 'D:\automation\backup' /E

Copy-Item -Path '.\src\backup\daily.bkp.ps1' -Destination 'D:\automation\backup'
Copy-Item -Path '.\src\backup\weekly.bkp.ps1' -Destination 'D:\automation\backup'
Copy-Item -Path '.\src\backup\monthly.bkp.ps1' -Destination 'D:\automation\backup'
