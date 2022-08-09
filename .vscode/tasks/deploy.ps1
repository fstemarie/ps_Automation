Write-Host "Deploying scripts to D:\automation"
Copy-Item -Path '.\src\*.ps1' -Destination 'D:\automation'
