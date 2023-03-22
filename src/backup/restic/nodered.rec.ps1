$dst = "D:\services\node-red"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "nodered.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = "$env:AUTOMATION\log\nodered.restic.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#----------------------------------------------------------------------
#region Recuperation du dossier nodered sur Storj
Write-Host "-------------------------------------"
Write-Host " Restoring nodered folder from Storj "
Write-Host "-------------------------------------"

if (!(Test-Path env:\RESTIC_REPOSITORY)) {
    Write-Host "nodered.rec.ps1 -- RESTIC_REPOSITORY empty"
    exit 1
}

if (!(Test-Path env:\RESTIC_PASSWORD)) {
    Write-Host "nodered.rec.ps1 -- RESTIC_PASSWORD empty"
    exit 1
}

if (Test-Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    "--tag=nodered"
    "--verbose"
    "--target=" + (Split-Path $dst -Parent)
)
restic restore latest @params
if (!$?) {
    Write-Host "nodered.rec.ps1 -- Data restoration failed"
    exit 1
}
Write-Host "nodered.rec.ps1 -- Data restoration successful"

Stop-Transcript
