Start-Transcript `
    -Path D:\automation\log\documents.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 45)
Write-Host "| Sauvegarde du dossier documents sur Storj |"
Write-Host ("-" * 45)

$src = "D:\Francois\Documents"

if (!Test-Path Env:RESTIC_REPOSITORY) {
    Write-Host "documents.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (!Test-Path Env:\RESTIC_PASSWORD) {
    Write-Host "documents.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (!Test-Path $src) {
    Write-Host "documents.bkp.ps1 -- Source folder does not exist"
    exit
}

Write-Host "documents.bkp.ps1 -- Source folder: $src"
Write-Host "documents.bkp.ps1 -- Creating restic snapshot"
$params = @(
    '--host=HX90'
    '--tag=documents'
    '--verbose'
    '--exclude=Development'
    $src
)
restic backup @params

if (!$?) {
    Write-Host "documents.bkp.ps1 -- There was an error during the snapshot"
    exit
}
Write-Host "documents.bkp.ps1 -- Snapshot created successfully"

Write-Host "documents.bkp.ps1 -- Forgetting snapshots"
$params = @(
    '--host=HX90'
    '--tag=documents'
    '--prune'
    '--keep-weekly=8'
    '--keep-monthly=12'
    '--keep-yearly=4'
)
restic forget @params

if (!$?) {
    Write-Host "documents.bkp.ps1 -- Unable to forget snapshots"
    exit
}
Write-Host "documents.bkp.ps1 -- Snapshots forgotten successfully"

Stop-Transcript