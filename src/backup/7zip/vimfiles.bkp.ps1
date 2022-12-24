Start-Transcript `
    -Path D:\automation\log\vimfiles.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
# Sauvegarde du dossier Services sur Raktar
Write-Host "┌────────────────────────────────────────┐"
Write-Host "│ Sauvegarde de la config Vim sur Raktar │"
Write-Host "└────────────────────────────────────────┘"

$src = "D:\Francois\vimfiles"
$dst = "\\raktar.local\backup\HX90\vimfiles"
$arc = Join-Path $dst "vimfiles.$(Get-Date -Format FileDateTime).7z"

# if the source folder doesn't exist, then there is nothing to backup
if (-not (Test-Path $src)) {
    Write-Host "vimfiles.bkp.ps1 -- Source folder does not exist"
    exit
}

# if the destination folder does not exist, create it
if (-not (Test-Path $dst)) {
    Write-Host "vimfiles.bkp.ps1 -- Creating non-existent destination"
    New-Item -ItemType Directory $dst -Force
}

$params = @(
    "-mx=9"
    $arc
    $src
)
7z u @params

Stop-Transcript
