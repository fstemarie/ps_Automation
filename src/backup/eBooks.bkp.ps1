#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host ("-" * 43)
Write-Host "| Sauvegarde du dossier eBooks sur Raktar |"
Write-Host ("-" * 43)

$source = "D:\Francois\eBooks"
$arch = "\\raktar\backup\HX90\eBooks\eBooks.7z"
$params = @(
    "-mx=9"
    $arch
    $source
)
7z u @params
#endregion
