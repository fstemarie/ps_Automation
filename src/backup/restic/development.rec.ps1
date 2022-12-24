Start-Transcript `
    -Path D:\automation\log\development.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Recuperation du dossier development sur Storj
Write-Host "┌─────────────────────────────────────────┐"
Write-Host "│ Restoring development folder from Storj │"
Write-Host "└─────────────────────────────────────────┘"

if (-not(Test-Path -Path Env:\RESTIC_REPOSITORY)) {
    Write-Host "development.rec.ps1 -- RESTIC_REPOSITORY empty"
    Exit 1
}

if (-not(Test-Path -Path Env:\RESTIC_PASSWORD)) {
    Write-Host "development.rec.ps1 -- RESTIC_PASSWORD empty"
    Exit 1
}

$dst = "D:\francois\Documents\Development"
if (Test-Path -Path $dst -PathType Container) {
    Write-Host "development.rec.ps1 -- Moving pre-existing destination"
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

Write-Host "development.rec.ps1 -- Restoring data"
$params = @(
    '--tag=development'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
if ($?) {
    Write-Host "development.rec.ps1 -- Data restoration successful"

    Write-Host "development.rec.ps1 -- Moving folder to original location"
    Move-Item -Path "D:\D\francois" -Destination "D:\" -Force
    Remove-Item -Path "D:\D"
} else {
    Write-Host "development.rec.ps1 -- Data restoration failed"
    Exit 1
}

Stop-Transcript