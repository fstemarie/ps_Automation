$src = ([Environment]::GetFolderPath("MyDocuments"))
$dst = "\\raktar.local\backup\HX90\documents"
$arc = "$dst\documents.7z"
$inc = "$dst\documents.$(Get-Date -Format FileDateTime).7z"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "development.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = "$env:AUTOMATION\log\documents.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host "--------------------------------------------"
Write-Host " Sauvegarde du dossier documents sur Raktar "
Write-Host "--------------------------------------------"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path $src)) {
    Write-Host "documents.bkp.ps1 -- Source folder does not exist"
    exit
}

# if the destination folder does not exist, create it
if (!(Test-Path $dst)) {
    Write-Host "documents.bkp.ps1 -- Creating non-existent destination"
    New-Item $dst -ItemType Directory
}

if (Test-Path $arc -PathType Leaf) {
    $params = @(
        "-u-"
        "-up1q1r3x1y1z0w1!$inc"
        "-xr!Development"
        "-mx=9"
        $arc
        $src
    )
    7z u @params
}

# Mise a jour de la sauvegarde complete
$params = @(
    "-up0q0r2x2y2z1w2"
    "-xr!Development"
    "-mx=9"
    $arc
    $src
)
7z u @params
#endregion

Stop-Transcript
