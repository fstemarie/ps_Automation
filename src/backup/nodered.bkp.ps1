#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de Node-RED sur Raktar
Write-Host ("-" * 57)
Write-Host "| Sauvegarde de la configuration de Node-RED sur Raktar |"
Write-Host ("-" * 57)

$source = "D:\services\node-red"
$dest = "\\raktar\Storage\backup\node-red"
$arch = "$dest\node-red.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-xr!node_modules"
    "-mx=9"
    $arch
    $source
)
7z u @params
#endregion
