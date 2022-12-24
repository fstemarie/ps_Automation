Start-Transcript `
    -Path D:\automation\log\nodered.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host "┌──────────────────────────────────────────┐"
Write-Host "│ Sauvegarde du dossier node-red sur Storj │"
Write-Host "└──────────────────────────────────────────┘"

$src = "D:\services\node-red"

if (-not (Test-Path Env:RESTIC_REPOSITORY)) {
    Write-Host "nodered.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (-not (Test-Path Env:\RESTIC_PASSWORD)) {
    Write-Host "nodered.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (-not (Test-Path $src)) {
    Write-Host "nodered.bkp.ps1 -- Source folder does not exist"
    exit
}

Write-Host "nodered.bkp.ps1 -- Source folder: $src"
Write-Host "nodered.bkp.ps1 -- Creating restic snapshot"
$params = @(
    '--host=HX90'
    '--tag=nodered'
    '--verbose'
    '--exclude=node-red/*.log'
    '--exclude=node_modules'
    '--exclude=.sshkeys'
    $src
)
restic backup @params

if (!$?) {
    Write-Host "nodered.bkp.ps1 -- There was an error during the snapshot"
    exit
}
Write-Host "nodered.bkp.ps1 -- Snapshot created successfully"

Write-Host "nodered.bkp.ps1 -- Forgetting snapshots"
$params = @(
    '--host=HX90'
    '--tag=nodered'
    '--keep-last=3'
)
restic forget @params

if (!$?) {
    Write-Host "nodered.bkp.ps1 -- Unable to forget snapshots"
    exit
}
Write-Host "nodered.bkp.ps1 -- Snapshots forgotten successfully"

Stop-Transcript