Start-Transcript `
    -Path D:\automation\log\rclone.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
# Sauvegarde de la configuration de rClone sur Raktar
Write-Host "-------------------------------------------------------"
Write-Host "| Sauvegarde de la configuration de rClone sur Raktar |"
Write-Host "-------------------------------------------------------"

$src = "D:\services\rclone"
$dst = "\\raktar.local\backup\HX90\rclone"
$arc = Join-Path $dst "rclone.$(Get-Date -Format FileDateTime).7z"

# if the source folder doesn't exist, then there is nothing to backup
if (-not (Test-Path $src)) {
    Write-Host "rclone.bkp.ps1 -- Source folder does not exist"
    exit
}

# if the destination folder does not exist, create it
if (-not (Test-Path $dst)) {
    Write-Host "rclone.bkp.ps1 -- Creating non-existent destination"
    New-Item -ItemType Directory $dst -Force
}

$params = @(
    "-mx=9"
    $arc
    $src
)
7z u @params

Stop-Transcript
