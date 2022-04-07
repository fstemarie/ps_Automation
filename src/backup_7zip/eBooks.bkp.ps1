Start-Transcript `
    -Path D:\automation\log\eBooks.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host ("-" * 43)
Write-Host "| Sauvegarde du dossier eBooks sur Raktar |"
Write-Host ("-" * 43)

$src = "D:\Francois\eBooks"
$arc = "\\raktar\backup\HX90\eBooks\eBooks.7z"
$params = @(
    "-mx=9"
    $arc
    $src
)
7z u @params
#endregion

Stop-Transcript
