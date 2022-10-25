Start-Transcript `
    -Path D:\automation\log\rclone.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 42)
Write-Host "| Sauvegarde du dossier rclone sur Storj |"
Write-Host ("-" * 42)

$src = "D:\services\rclone"

if (!Test-Path Env:RESTIC_REPOSITORY) {
    Write-Host "rclone.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (!Test-Path Env:\RESTIC_PASSWORD) {
    Write-Host "rclone.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (!Test-Path $src) {
    Write-Host "rclone.bkp.ps1 -- Source folder does not exist"
    exit
}

Write-Host "rclone.bkp.ps1 -- Source folder: $src"
Write-Host "rclone.bkp.ps1 -- Creating restic snapshot"
$params = @(
    '--host=HX90'
    '--tag=rclone'
    '--verbose'
    $src
)
restic backup @params

if (!$?) {
    Write-Host "rclone.bkp.ps1 -- There was an error during the snapshot"
    exit
}
Write-Host "rclone.bkp.ps1 -- Snapshot created successfully"

Write-Host "rclone.bkp.ps1 -- Forgetting snapshots"
$params = @(
    '--host=HX90'
    '--tag=rclone'
    '--prune'
    '--keep-last=3'
)
restic forget @params

if (!$?) {
    Write-Host "rclone.bkp.ps1 -- Unable to forget snapshots"
    exit
}
Write-Host "rclone.bkp.ps1 -- Snapshots forgotten successfully"

Stop-Transcript