Start-Transcript `
    -Path D:\automation\log\development.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host "-----------------------------------------------"
Write-Host "| Sauvegarde du dossier development sur Storj |"
Write-Host "-----------------------------------------------"

$src = "D:\Francois\Documents\Development"

if (-not (Test-Path Env:RESTIC_REPOSITORY)) {
    Write-Host "development.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (-not (Test-Path Env:\RESTIC_PASSWORD)) {
    Write-Host "development.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (-not (Test-Path $src)) {
    Write-Host "development.bkp.ps1 -- Source folder does not exist"
    exit
}

Write-Host "development.bkp.ps1 -- Source folder: $src"
Write-Host "development.bkp.ps1 -- Creating restic snapshot"

$params = @(
    '--host=HX90'
    '--tag=development'
    '--verbose'
    '--exclude=.venv'
    '--exclude=node_modules'
    $src
)
restic backup @params

if (!$?) {
    Write-Host "development.bkp.ps1 -- There was an error during the snapshot"
    exit
}
Write-Host "development.bkp.ps1 -- Snapshot created successfully"

Write-Host "development.bkp.ps1 -- Forgetting snapshots"
$params = @(
    '--host=HX90'
    '--tag=development'
    '--keep-daily=14'
    '--keep-monthly=6'
)
restic forget @params

if (!$?) {
    Write-Host "development.bkp.ps1 -- Unable to forget snapshots"
    exit
}
Write-Host "development.bkp.ps1 -- Snapshots forgotten successfully"

Stop-Transcript