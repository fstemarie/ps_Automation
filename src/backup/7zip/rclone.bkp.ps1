$src = Join-Path $env:SERVICES "rclone"
$dst = "\\raktar.local\backup\HX90\rclone"
$arc = Join-Path $dst "rclone.$(Get-Date -Format FileDateTime).7z"

if (!$env:SERVICES -Or !(Test-Path "$env:SERVICES")) {
    Write-Error "rclone.bkp.ps1 -- %SERVICES% empty or invalid. Cannot proceed"
    exit 1
}

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "rclone.bkp.ps1 -- %AUTOMATION% empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "rclone.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde de la configuration de rClone sur Raktar
Write-Host "`n`n"
Write-Host "-----------------------------------------------------"
Write-Host " Sauvegarde de la configuration de rClone sur Raktar "
Write-Host "-----------------------------------------------------"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path $src)) {
    Write-Host "rclone.bkp.ps1 -- Source folder does not exist"
    exit 1
}

# if the destination folder does not exist, create it
if (!(Test-Path $dst)) {
    Write-Host "rclone.bkp.ps1 -- Creating non-existent destination"
    New-Item $dst -ItemType Directory -Force
}

$params = @(
    "-mx=9"
    "-x!rclone/rclone.log"
    $arc
    $src
)
7z u @params

$nb_max = 5
$bkps = Get-Item (Join-Path $dst "rclone.*.7z") | Sort-Object
if ($bkps.Count -gt $nb_max) {
    Write-Host "rclone.bkp.ps1 -- Enleve les fichiers de sauvegardes de trop"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
