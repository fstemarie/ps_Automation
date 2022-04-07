Write-Host "Deploying scripts to D:\automation"
robocopy '.\src\backup\restic' 'D:\automation\backup\restic' /E
Copy-Item -Path '.\src\backup\weekly.bkp.ps1' -Destination 'D:\automation\backup'
