#-----------------------------------------------------------------------
#region Sauvegarde du dossier Services sur Raktar
Write-Host ("-" * 42)
Write-Host "| Sauvegarde de la config Vim sur Raktar |"
Write-Host ("-" * 42)

$source = "D:\Francois\vimfiles"
$arch = "\\raktar\backup\HX90\vimfiles\vimfiles.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    $arch
    $source
)
7z u @params
#endregion
