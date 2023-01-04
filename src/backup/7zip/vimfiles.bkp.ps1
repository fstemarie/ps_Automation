$src = "D:\Francois\vimfiles"
$dst = "\\raktar.local\backup\HX90\vimfiles"
$arc = Join-Path $dst "vimfiles.$(Get-Date -Format FileDateTime).7z"

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "vimfiles.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde du dossier Services sur Raktar
Write-Host "┌────────────────────────────────────────┐"
Write-Host "│ Sauvegarde de la config Vim sur Raktar │"
Write-Host "└────────────────────────────────────────┘"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path $src)) {
    Write-Host "vimfiles.bkp.ps1 -- Source folder does not exist"
    exit 1
}

# if the destination folder does not exist, create it
if (!(Test-Path $dst)) {
    Write-Host "vimfiles.bkp.ps1 -- Creating non-existent destination"
    New-Item $dst -ItemType Directory -Force
}

$params = @(
    "-mx=9"
    $arc
    $src
)
7z u @params

Stop-Transcript
