$src = "D:\Francois\vimfiles"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "vimfiles.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "vimfiles.restic.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host "`n`n"
Write-Host "-------------------------------------------"
Write-Host " Backup of the vimfiles folder with restic "
Write-Host "-------------------------------------------"

if (!(Test-Path env:RESTIC_REPOSITORY)) {
    Write-Host "vimfiles.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit 1
}

if (!(Test-Path env:RESTIC_PASSWORD)) {
    Write-Host "vimfiles.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit 1
}

if (!(Test-Path $src)) {
    Write-Host "vimfiles.bkp.ps1 -- Source folder does not exist"
    exit 1
}

Write-Host "vimfiles.bkp.ps1 -- Source folder: $src"
Write-Host "vimfiles.bkp.ps1 -- Creating restic snapshot"
$params = @(
    '--host=HX90'
    '--tag=vimfiles'
    '--verbose'
    (Split-Path $src -Leaf)
)
Push-Location (Split-Path $src -Parent)
restic backup @params
Pop-Location
if (!$?) {
    Write-Host "vimfiles.bkp.ps1 -- There was an error during the snapshot"
    exit 1
}
Write-Host "vimfiles.bkp.ps1 -- Snapshot created successfully"

Write-Host "vimfiles.bkp.ps1 -- Forgetting snapshots"
$params = @(
    '--host=HX90'
    '--tag=vimfiles'
    '--keep-last=3'
)
restic forget @params
if (!$?) {
    Write-Host "vimfiles.bkp.ps1 -- Unable to forget snapshots"
    exit 1
}
Write-Host "vimfiles.bkp.ps1 -- Snapshots forgotten successfully"

Stop-Transcript