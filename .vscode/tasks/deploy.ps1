Write-Host "Deploying scripts to D:\automation"

$dst = 'D:\automation\backup'
Remove-Item -Force -Recurse $dst -ErrorAction SilentlyContinue
$src = '.\src'
Copy-Item -Path (Join-Path $src '*.ps1') -Destination 'D:\automation'
$src = Join-Path $src 'backup'
Copy-Item -Path $src -Destination 'D:\automation'
