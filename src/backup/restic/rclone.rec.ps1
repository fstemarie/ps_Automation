$dst = "D:\services\rclone"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = "$env:AUTOMATION\log\rclone.restic.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#----------------------------------------------------------------------
#region Recuperation du dossier rclone sur Storj
Write-Host "------------------------------------"
Write-Host " Restoring rclone folder from Storj "
Write-Host "------------------------------------"

if (!(Test-Path env:\RESTIC_REPOSITORY)) {
    Write-Host "rclone.rec.ps1 -- RESTIC_REPOSITORY empty"
    exit 1
}

if (!(Test-Path env:\RESTIC_PASSWORD)) {
    Write-Host "rclone.rec.ps1 -- RESTIC_PASSWORD empty"
    exit 1
}

if (Test-Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    "--tag=rclone"
    "--verbose"
    "--target=" + (Split-Path $dst -Parent)
)
restic restore latest @params
if (!$?) {
    Write-Host "rclone.rec.ps1 -- Data restoration failed"
    exit 1
}
Write-Host "rclone.rec.ps1 -- Data restoration successful"

Stop-Transcript
