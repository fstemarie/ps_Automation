Start-Transcript `
    -Path D:\automation\log\eBooks.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 42)
Write-Host "| Sauvegarde du dossier eBooks sur Storj |"
Write-Host ("-" * 42)

$src = "D:\Francois\eBooks"

if (-not (Test-Path Env:RESTIC_REPOSITORY)) {
    Write-Host "eBooks.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (-not (Test-Path Env:\RESTIC_PASSWORD)) {
    Write-Host "eBooks.bkp.ps1 -- RESTIC_REPOSITORY empty. Cannot proceed"
    exit
}

if (-not (Test-Path $src)) {
    Write-Host "eBooks.bkp.ps1 -- Source folder does not exist"
    exit
}

Write-Host "eBooks.bkp.ps1 -- Source folder: $src"
Write-Host "eBooks.bkp.ps1 -- Creating restic snapshot"
$params = @(
    '--host=HX90'
    '--tag=eBooks'
    '--verbose'
    $src
)
restic backup @params

if (!$?) {
    Write-Host "eBooks.bkp.ps1 -- There was an error during the snapshot"
    exit
}
Write-Host "eBooks.bkp.ps1 -- Snapshot created successfully"

Write-Host "eBooks.bkp.ps1 -- Forgetting snapshots"
$params = @(
    '--host=HX90'
    '--tag=eBooks'
    '--keep-monthly=6'
)
restic forget @params

if (!$?) {
    Write-Host "eBooks.bkp.ps1 -- Unable to forget snapshots"
    exit
}
Write-Host "eBooks.bkp.ps1 -- Snapshots forgotten successfully"

Stop-Transcript