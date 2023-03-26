$src = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "Development"
$dst = "\\raktar.local\backup\HX90\development"
$arc = Join-Path $dst "development.7z"
$inc = Join-Path $dst "development.$(Get-Date -Format FileDateTime).7z"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "development.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Raktar
Write-Host "----------------------------------------------"
Write-Host " Sauvegarde du dossier development sur Raktar "
Write-Host "----------------------------------------------"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path $src)) {
    Write-Host "development.bkp.ps1 -- Source folder does not exist"
    exit 1
}

Write-Host "development.bkp.ps1 -- Source folder: $src"

# if the destination folder does not exist, create it
if (!(Test-Path $dst)) {
    Write-Host "development.bkp.ps1 -- Creating non-existent destination"
    New-Item -ItemType Directory $dst
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
#endregion

Stop-Transcript
