Start-Transcript `
    -Path D:\automation\log\nodered.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
# Sauvegarde de la configuration de Node-RED sur Raktar
Write-Host "---------------------------------------------------------"
Write-Host "| Sauvegarde de la configuration de Node-RED sur Raktar |"
Write-Host "---------------------------------------------------------"

$src = "D:\services\node-red"
$dst = "\\raktar.local\backup\HX90\nodered"
$arc = Join-Path $dst "nodered.$(Get-Date -Format FileDateTime).7z"

# if the source folder doesn't exist, then there is nothing to backup
if (-not (Test-Path $src)) {
    Write-Host "nodered.bkp.ps1 -- Source folder does not exist"
    exit
}

# if the destination folder does not exist, create it
if (-not (Test-Path $dst)) {
    Write-Host "nodered.bkp.ps1 -- Creating non-existent destination"
    New-Item -ItemType Directory $dst -Force
}

$params = @(
    "-x!node-red/*.log"
    "-xr!node_modules"
    "-xr!.sshkeys"
    "-mx=9"
    $arc
    $src
)
7z u @params

$nb_max = 5
$bkps = Get-Item (Join-Path $dst "nodered.*.7z") | Sort-Object
if ($bkps.Count -gt $nb_max) {
    Write-Host "Enleve les fichiers de sauvegardes de trop"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
