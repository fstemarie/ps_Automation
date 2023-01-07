$dst = "D:\francois\Documents"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = "$env:AUTOMATION\log\documents.restic.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#----------------------------------------------------------------------
#region Recuperation du dossier documents sur Storj
Write-Host "---------------------------------------"
Write-Host " Restoring documents folder from storj "
Write-Host "---------------------------------------"

if (!(Test-Path env:\RESTIC_REPOSITORY)) {
    Write-Host "documents.rec.ps1 -- RESTIC_REPOSITORY empty"
    exit 1
}

if (!(Test-Path env:\RESTIC_PASSWORD)) {
    Write-Host "documents.rec.ps1 -- RESTIC_PASSWORD empty"
    exit 1
}

if (Test-Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    "--tag=documents"
    "--verbose"
    "--target=" + (Split-Path $dst -Parent)
)
restic restore latest @params
if (!$?) {
    Write-Host "documents.rec.ps1 -- Data restoration failed"
    exit 1
}
Write-Host "documents.rec.ps1 -- Data restoration successful"

Stop-Transcript