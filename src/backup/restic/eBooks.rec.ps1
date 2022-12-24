Start-Transcript `
    -Path D:\automation\log\eBooks.restic.log `
    -Append -IncludeInvocationHeader

    #----------------------------------------------------------------------
#region Recuperation du dossier eBooks sur Storj
Write-Host "┌────────────────────────────────────┐"
Write-Host "│ Restoring eBooks folder from Storj │"
Write-Host "└────────────────────────────────────┘"

if (-not(Test-Path -Path Env:\RESTIC_REPOSITORY)) {
    Write-Host "eBooks.rec.ps1 -- RESTIC_REPOSITORY empty"
    Exit 1
}

if (-not(Test-Path -Path Env:\RESTIC_PASSWORD)) {
    Write-Host "eBooks.rec.ps1 -- RESTIC_PASSWORD empty"
    Exit 1
}

$dst = "D:\francois\eBooks"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=eBooks'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
if ($?) {
    Write-Host "eBooks.rec.ps1 -- Data restoration successful"

    Write-Host "eBooks.rec.ps1 -- Moving folder to original location"
    Move-Item -Path "D:\D\francois" -Destination "D:\" -Force
    Remove-Item -Path "D:\D"
} else {
    Write-Host "eBooks.rec.ps1 -- Data restoration failed"
    Exit 1
}

Stop-Transcript
