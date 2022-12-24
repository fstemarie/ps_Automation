Start-Transcript `
    -Path D:\automation\log\rclone.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Recuperation du dossier rclone sur Storj
Write-Host "┌────────────────────────────────────┐"
Write-Host "│ Restoring rclone folder from Storj │"
Write-Host "└────────────────────────────────────┘"

if (-not(Test-Path -Path Env:\RESTIC_REPOSITORY)) {
    Write-Host "rclone.rec.ps1 -- RESTIC_REPOSITORY empty"
    Exit 1
}

if (-not(Test-Path -Path Env:\RESTIC_PASSWORD)) {
    Write-Host "rclone.rec.ps1 -- RESTIC_PASSWORD empty"
    Exit 1
}

$dst = "D:\services\rclone"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=rclone'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
if ($?) {
    Write-Host "rclone.rec.ps1 -- Data restoration successful"

    Write-Host "rclone.rec.ps1 -- Moving folder to original location"
    Move-Item -Path "D:\D\services" -Destination "D:\" -Force
    Remove-Item -Path "D:\D"
} else {
    Write-Host "rclone.rec.ps1 -- Data restoration failed"
    Exit 1
}

Stop-Transcript
