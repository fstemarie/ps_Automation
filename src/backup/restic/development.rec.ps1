$dst = "D:\francois\Documents\Development"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.rec.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = "$env:AUTOMATION\log\development.restic.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#----------------------------------------------------------------------
#region Recuperation du dossier development sur Storj
Write-Host "-----------------------------------------"
Write-Host " Restoring development folder from Storj "
Write-Host "-----------------------------------------"

if (!(Test-Path env:\RESTIC_REPOSITORY)) {
    Write-Error "development.rec.ps1 -- RESTIC_REPOSITORY empty"
    exit 1
}

if (!(Test-Path env:\RESTIC_PASSWORD)) {
    Write-Error "development.rec.ps1 -- RESTIC_PASSWORD empty"
    exit 1
}

if (Test-Path $dst -PathType Container) {
    Write-Host "development.rec.ps1 -- Moving pre-existing destination"
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

Write-Host "development.rec.ps1 -- Restoring data"
$params = @(
    "--tag=development"
    "--verbose"
    "--target=" + (Split-Path $dst -Parent)
)
restic restore latest @params
if (!$?) {
    Write-Error "development.rec.ps1 -- Data restoration failed"
    exit 1
}
Write-Host "development.rec.ps1 -- Data restoration successful"

Stop-Transcript