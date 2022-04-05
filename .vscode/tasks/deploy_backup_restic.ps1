Write-Host "Deploying scripts to D:\automation"
robocopy '.\src\backup_restic' 'D:\automation\backup_restic\' /E
