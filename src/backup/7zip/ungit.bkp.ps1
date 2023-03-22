$src = Join-Path $env:SERVICES "ungit"
$dst = "\\raktar.local\backup\HX90\ungit"
$arc = Join-Path $dst "ungit.$(Get-Date -Format FileDateTime).7z"

if (!$env:SERVICES -Or !(Test-Path "$env:SERVICES")) {
    Write-Error "ungit.bkp.ps1 -- %SERVICES% empty or invalid. Cannot proceed"
    exit 1
}

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "ungit.bkp.ps1 -- %AUTOMATION% empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path                    = Join-Path $env:AUTOMATION "log" "ungit.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde de la configuration de Ungit sur Raktar
Write-Host "----------------------------------------------------"
Write-Host " Sauvegarde de la configuration de Ungit sur Raktar "
Write-Host "----------------------------------------------------"

# if the source folder doesn't exist, then there is nothing to backup
if (!(Test-Path $src)) {
    Write-Host "ungit.bkp.ps1 -- Source folder does not exist"
    exit 1
}

$params = @(
    "-xr!node_modules"
    "-mx=9"
    $arc
    $src
)
7z u @params

$nb_max = 5
$bkps = Get-Item (Join-Path $dst "ungit.*.7z") | Sort-Object
if ($bkps.Count -gt $nb_max) {
    Write-Host "ungit.bkp.ps1 -- Enleve les fichiers de sauvegardes de trop"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
