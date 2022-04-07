Write-Host "Deploying scripts to D:\automation"
robocopy '.\src\backup\robocopy' 'D:\automation\backup\robocopy' /E
Copy-Item -Path '.\src\backup\weekly.bkp.ps1' -Destination 'D:\automation\backup'
