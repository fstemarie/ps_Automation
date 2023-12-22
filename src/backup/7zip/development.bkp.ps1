if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$src = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "Development"
$dst = "\\raktar.local\backup\HX90\development"
$arc = Join-Path $dst "development.7z"
$inc = Join-Path $dst "development.$(Get-Date -Format FileDateTime).7z"

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "development.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Raktar
Write-Host "`n`n"
Write-Host "--------------------------------------------"
Write-Host " Backup of the development folder on raktar "
Write-Host "--------------------------------------------"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path "$src")) {
    Write-Host "development.bkp.ps1 -- Source folder does not exist"
    exit 1
}

Write-Host "development.bkp.ps1 -- Source folder: $src"

if (!(Test-Path "$dst")) {
    Write-Host "development.bkp.ps1 -- Destination unreachable"
    exit 1
}

# Reset backups every first of the month
if ((Get-Date -Format 'dd') -eq 1) {
    Remove-Item (Join-Path $dst "*.*")
}

if (Test-Path $arc -PathType Leaf) {
    $params = @(
        "-mx=9"
        "-u-"
        "-up1q1r3x1y1z0w1!$inc"
        "-xr!node_modules"
        "-xr!.venv"
        $arc
        $src
    )
    7z u @params
    if (!$?) {
        Write-Error "development.bkp.ps1 -- Error while creating the archive (incremental file)"
        exit 1
    }
}

# Mise a jour de la sauvegarde complete
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    "-xr!node_modules"
    "-xr!.venv"
    $arc
    $src
)
7z u @params
if (!$?) {
    Write-Error "development.bkp.ps1 -- Error while updating the main archive"
    exit 1
}

Stop-Transcript
