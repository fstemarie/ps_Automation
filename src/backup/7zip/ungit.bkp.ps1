Start-Transcript `
    -Path D:\automation\log\ungit.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
# Sauvegarde de la configuration de Ungit sur Raktar
Write-Host "┌────────────────────────────────────────────────────┐"
Write-Host "│ Sauvegarde de la configuration de Ungit sur Raktar │"
Write-Host "└────────────────────────────────────────────────────┘"

$src = "D:\services\ungit"
$dst = "\\raktar.local\backup\HX90\ungit"
$arc = Join-Path $dst "ungit.$(Get-Date -Format FileDateTime).7z"

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
    Write-Host "Enleve les fichiers de sauvegardes de trop"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
