Start-Transcript `
    -Path D:\automation\log\ungit.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de Node-RED sur Raktar
Write-Host ("-" * 53)
Write-Host "| Sauvegarde de la configuration de Ungit sur Raktar |"
Write-Host ("-" * 53)

$src = "D:\services\ungit"
$arc = "\\raktar\backup\HX90\ungit\ungit.7z"
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
