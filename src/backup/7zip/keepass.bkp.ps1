if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "keepass.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$src = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "KeePass" "onedrive - o"
$dst = "\\raktar.local\backup\HX90\keepass"
$arc = Join-Path $dst "keepass.$(Get-Date -Format FileDateTime).7z"

if (!(Test-Path "$src")) {
    Write-Error "keepass.bkp.ps1 -- KeePass backup directory not found. Cannot proceed"
    exit 1
}

if (!(Test-Path "$dst")) {
    Write-Error "keepass.bkp.ps1 -- Destination unreachable"
    exit 1
}

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "keepass.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde des documents Keepass sur Raktar
Write-Host "`n`n"
Write-Host "----------------------------------------"
Write-Host " Backup of the KeePass config on raktar "
Write-Host "----------------------------------------"

$params = @(
    "-mx=9"
    $arc
    "${env:APPDATA}\KeePass\KeePass.config.xml"
    "${src}\Passwords.kdbx"
    "${src}\Discarded.kdbx"
)

Push-Location -Path C:\
7z u @params
if (!$?) {
    Write-Error "keepass.bkp.ps1 -- Error while creating the archive"
    exit 1
}
Pop-Location

$nb_max = 5
$bkps = Get-Item (Join-Path $dst "keepass.*.7z") | Sort-Object
if ($bkps.Count -gt $nb_max) {
    Write-Host "keepass.bkp.ps1 -- Removing old files"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
