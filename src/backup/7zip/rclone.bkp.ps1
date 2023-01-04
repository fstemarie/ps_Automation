$src = "D:\services\rclone"
$dst = "\\raktar.local\backup\HX90\rclone"
$arc = Join-Path $dst "rclone.$(Get-Date -Format FileDateTime).7z"

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "rclone.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde de la configuration de rClone sur Raktar
Write-Host "┌─────────────────────────────────────────────────────┐"
Write-Host "│ Sauvegarde de la configuration de rClone sur Raktar │"
Write-Host "└─────────────────────────────────────────────────────┘"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path $src)) {
    Write-Host "rclone.bkp.ps1 -- Source folder does not exist"
    exit 1
}

# if the destination folder does not exist, create it
if (!(Test-Path $dst)) {
    Write-Host "rclone.bkp.ps1 -- Creating non-existent destination"
    New-Item $dst -ItemType Directory -Force
}

$params = @(
    "-mx=9"
    $arc
    $src
)
7z u @params

Stop-Transcript
