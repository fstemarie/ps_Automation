Write-Host "Deploying scripts to D:\automation"

Remove-Item -Force -Recurse 'D:\automation\backup' -ErrorAction SilentlyContinue
Copy-Item -Path (Join-Path 'src' '*.ps1') -Destination 'D:\automation'
Copy-Item -Path (Join-Path 'src' 'backup') -Destination 'D:\automation' -Recurse
