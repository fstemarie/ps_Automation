#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de Node-RED sur Raktar
Write-Host ("-" * 53)
Write-Host "| Sauvegarde de la configuration de Ungit sur Raktar |"
Write-Host ("-" * 53)

$source = "D:\services\ungit"
$arch = "\\raktar\Storage\backup\HX90\ungit\ungit.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-xr!node_modules"
    "-mx=9"
    $arch
    $source
)
7z u @params
#endregion
