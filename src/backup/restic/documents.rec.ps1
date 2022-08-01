Start-Transcript `
    -Path D:\automation\log\documents.restic.log `
    -Append -IncludeInvocationHeader

    #----------------------------------------------------------------------
#region Recuperation du dossier documents sur Storj
Write-Host ("-" * 47)
Write-Host "| Restoring documents folder from storj |"
Write-Host ("-" * 47)


if (-not(Test-Path -Path Env:\RESTIC_REPOSITORY)) {
    Write-Host "documents.rec.ps1 -- RESTIC_REPOSITORY empty"
    Exit 1
}

if (-not(Test-Path -Path Env:\RESTIC_PASSWORD)) {
    Write-Host "documents.rec.ps1 -- RESTIC_PASSWORD empty"
    Exit 1
}

$dst = "D:\francois\Documents"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=documents'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
if ($?) {
    Write-Host "documents.rec.ps1 -- Data restoration successful"

    Write-Host "documents.rec.ps1 -- Moving folder to original location"
    Move-Item -Path "D:\D\francois" -Destination "D:\" -Force
    Remove-Item -Path "D:\D"
} else {
    Write-Host "documents.rec.ps1 -- Data restoration failed"
    Exit 1
}

Stop-Transcript