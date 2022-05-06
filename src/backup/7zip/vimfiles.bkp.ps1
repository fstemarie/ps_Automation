Start-Transcript `
    -Path D:\automation\log\vimfiles.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde du dossier Services sur Raktar
Write-Host ("-" * 42)
Write-Host "| Sauvegarde de la config Vim sur Raktar |"
Write-Host ("-" * 42)

$src = "D:\Francois\vimfiles"
$arc = "\\raktar.local\backup\HX90\vimfiles\vimfiles.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    $arc
    $src
)
7z u @params
#endregion

Stop-Transcript
