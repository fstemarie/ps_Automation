if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$src = ([Environment]::GetFolderPath("MyDocuments"))
$dst = "\\raktar.local\backup\HX90\documents"
$arc = "$dst\documents.7z"
$inc = "$dst\documents.$(Get-Date -Format FileDateTime).7z"

$params = @{
    Path                    = "$env:AUTOMATION\log\documents.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Backup of the documents folder on raktar
Write-Host "`n`n"
Write-Host "------------------------------------------"
Write-Host " Backup of the documents folder on raktar "
Write-Host "------------------------------------------"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path "$src")) {
    Write-Host "documents.bkp.ps1 -- Source folder does not exist"
    exit 1
}

# if the destination folder does not exist, create it
if (!(Test-Path "$dst")) {
    Write-Host "documents.bkp.ps1 -- Destination unreachable"
    exit 1
}

# Reset backups every first of the month
if ((Get-Date -Format 'dd') -eq 1) {
    Remove-Item (Join-Path $dst "*.*")
}

if (Test-Path $arc -PathType Leaf) {
    $params = @(
        "-u-"
        "-up1q1r3x1y1z0w1!$inc"
        "-xr!Development"
        "-xr!eBooks"
        "-mx=9"
        $arc
        $src
    )
    7z u @params
    if (!$?) {
        Write-Error "documents.bkp.ps1 -- Error while creating the archive (incremental file)"
        exit 1
    }
}

# Mise a jour de la sauvegarde complete
$params = @(
    "-up0q0r2x2y2z1w2"
    "-xr!Development"
    "-xr!eBooks"
    "-mx=9"
    $arc
    $src
)
7z u @params
if (!$?) {
    Write-Error "documents.bkp.ps1 -- Error while updating the main archive"
    exit 1
}

Stop-Transcript
