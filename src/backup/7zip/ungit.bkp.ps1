Start-Transcript `
    -Path D:\automation\log\ungit.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de Node-RED sur Raktar
Write-Host "------------------------------------------------------"
Write-Host "| Sauvegarde de la configuration de Ungit sur Raktar |"
Write-Host "------------------------------------------------------"

$src = "D:\services\ungit"
$arc = "\\raktar.local\backup\HX90\ungit\ungit.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-xr!node_modules"
    "-mx=9"
    $arc
    $src
)
7z u @params
#endregion

Stop-Transcript
