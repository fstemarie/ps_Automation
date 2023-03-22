Write-Host "Deploying scripts"

if (!$env:AUTOMATION) {
    Write-Error "La variable d'environnement AUTOMATION n'existe pas"
    exit
}

Remove-Item -Force -Recurse (Join-Path $env:AUTOMATION "backup") -ErrorAction SilentlyContinue
Copy-Item -Path (Join-Path 'src' '*.ps1') -Destination $env:AUTOMATION
Copy-Item -Path (Join-Path 'src' 'backup') -Destination $env:AUTOMATION -Recurse
