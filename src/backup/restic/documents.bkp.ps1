$src = "D:\Francois\Documents"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = "$env:AUTOMATION\log\documents.restic.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Storj
Write-Host "-------------------------------------------"
Write-Host " Sauvegarde du dossier documents sur Storj "
Write-Host "-------------------------------------------"

if (!(Test-Path env:RESTIC_REPOSITORY)) {
    Write-Host "documents.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit 1
}

if (!(Test-Path env:\RESTIC_PASSWORD)) {
    Write-Host "documents.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit 1
}

if (!(Test-Path $src)) {
    Write-Host "documents.bkp.ps1 -- Source folder does not exist"
    exit 1
}

Write-Host "documents.bkp.ps1 -- Source folder: $src"
Write-Host "documents.bkp.ps1 -- Creating restic snapshot"
$params = @(
    '--host=HX90'
    '--tag=documents'
    '--verbose'
    '--exclude=Development'
    (Split-Path $src -Leaf)
)
Push-Location (Split-Path $src -Parent)
restic backup @params
Pop-Location
if (!$?) {
    Write-Host "documents.bkp.ps1 -- There was an error during the snapshot"
    exit 1
}
Write-Host "documents.bkp.ps1 -- Snapshot created successfully"

Write-Host "documents.bkp.ps1 -- Forgetting snapshots"
$params = @(
    '--host=HX90'
    '--tag=documents'
    '--keep-weekly=4'
    '--keep-monthly=6'
    '--keep-yearly=4'
)
restic forget @params
if (!$?) {
    Write-Host "documents.bkp.ps1 -- Unable to forget snapshots"
    exit 1
}
Write-Host "documents.bkp.ps1 -- Snapshots forgotten successfully"

Stop-Transcript