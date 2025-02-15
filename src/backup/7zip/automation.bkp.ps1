if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "automation.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$src = $env:AUTOMATION
$dst = "\\raktar.local\backup\HX90\automation"
$arc = Join-Path $dst "automation.$(Get-Date -Format FileDateTime).7z"

if (!(Test-Path "$src")) {
    Write-Error "automation.bkp.ps1 -- backup directory not found. Cannot proceed"
    exit 1
}

if (!(Test-Path "$dst")) {
    Write-Error "automation.bkp.ps1 -- Destination unreachable"
    exit 1
}

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "automation.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde des documents Keepass sur Raktar
Write-Host "`n`n"
Write-Host "-------------------------------------------"
Write-Host " Backup of the automation config on raktar "
Write-Host "-------------------------------------------"

$params = @(
    "-mx=9"
    "-xr!log"
    $arc
    "${src}"
)

Push-Location -Path C:\
7z u @params
if (!$?) {
    Write-Error "automation.bkp.ps1 -- Error while creating the archive"
    exit 1
}
Pop-Location

$nb_max = 5
$bkps = Get-Item (Join-Path $dst "automation.*.7z") | Sort-Object
if ($bkps.Count -gt $nb_max) {
    Write-Host "automation.bkp.ps1 -- Removing old files"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
