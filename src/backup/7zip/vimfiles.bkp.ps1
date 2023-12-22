if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "vimfiles.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$src = "D:\francois\vimfiles"
$dst = "\\raktar.local\backup\HX90\vimfiles"
$arc = "$dst\vimfiles.$(Get-Date -Format FileDateTime).7z"

$params = @{
    Path                    = "$env:AUTOMATION\log\vimfiles.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde du dossier Services sur Raktar
Write-Host "`n`n"
Write-Host "----------------------------------------"
Write-Host " Sauvegarde de la config Vim sur Raktar "
Write-Host "----------------------------------------"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path "$src")) {
    Write-Host "vimfiles.bkp.ps1 -- Source folder does not exist"
    exit 1
}

if (!(Test-Path "$dst")) {
    Write-Host "vimfiles.bkp.ps1 -- Destination unreachable"
    exit 1
}

$params = @(
    "-mx=9"
    $arc
    $src
)
7z u @params
if (!$?) {
    Write-Error "vimfiles.bkp.ps1 -- Error while creating the archive"
    exit 1
}

$nb_max = 5
$bkps = Get-Item (Join-Path $dst "vimfiles.*.7z") | Sort-Object
if ($bkps.Count -gt $nb_max) {
    Write-Host "vimfiles.bkp.ps1 -- Removing old files"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
