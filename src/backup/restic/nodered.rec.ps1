Start-Transcript `
    -Path D:\automation\log\nodered.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Recuperation du dossier nodered sur Storj
Write-Host "┌─────────────────────────────────────┐"
Write-Host "│ Restoring nodered folder from Storj │"
Write-Host "└─────────────────────────────────────┘"

if (-not(Test-Path -Path Env:\RESTIC_REPOSITORY)) {
    Write-Host "nodered.rec.ps1 -- RESTIC_REPOSITORY empty"
    Exit 1
}

if (-not(Test-Path -Path Env:\RESTIC_PASSWORD)) {
    Write-Host "nodered.rec.ps1 -- RESTIC_PASSWORD empty"
    Exit 1
}

$dst = "D:\services\node-red"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=nodered'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
if ($?) {
    Write-Host "nodered.rec.ps1 -- Data restoration successful"

    Write-Host "nodered.rec.ps1 -- Moving folder to original location"
    Move-Item -Path "D:\D\services" -Destination "D:\" -Force
    Remove-Item -Path "D:\D"
} else {
    Write-Host "nodered.rec.ps1 -- Data restoration failed"
    Exit 1
}

Stop-Transcript
