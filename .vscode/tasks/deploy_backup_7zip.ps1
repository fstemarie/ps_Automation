Write-Host "Deploying scripts to D:\automation"
robocopy '.\src\backup\7zip' 'D:\automation\backup\7zip' /E
Copy-Item -Path '.\src\backup\weekly.bkp.ps1' -Destination 'D:\automation\backup'
