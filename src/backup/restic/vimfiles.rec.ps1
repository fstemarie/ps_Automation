Start-Transcript `
    -Path D:\automation\log\vimfiles.restic.log `
    -Append -IncludeInvocationHeader

#----------------------------------------------------------------------
#region Recuperation du dossier vimfiles sur Storj
Write-Host "┌──────────────────────────────────────┐"
Write-Host "│ Restoring vimfiles folder from Storj │"
Write-Host "└──────────────────────────────────────┘"

if (-not(Test-Path -Path Env:\RESTIC_REPOSITORY)) {
    Write-Host "vimfiles.rec.ps1 -- RESTIC_REPOSITORY empty"
    Exit 1
}

if (-not(Test-Path -Path Env:\RESTIC_PASSWORD)) {
    Write-Host "vimfiles.rec.ps1 -- RESTIC_PASSWORD empty"
    Exit 1
}

$dst = "D:\francois\vimfiles"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=vimfiles'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
if ($?) {
    Write-Host "vimfiles.rec.ps1 -- Data restoration successful"

    Write-Host "vimfiles.rec.ps1 -- Moving folder to original location"
    Move-Item -Path "D:\D\francois" -Destination "D:\" -Force
    Remove-Item -Path "D:\D"
} else {
    Write-Host "vimfiles.rec.ps1 -- Data restoration failed"
    Exit 1
}

Stop-Transcript
