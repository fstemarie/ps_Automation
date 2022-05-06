#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host ("-" * 43)
Write-Host "| Recuperation du dossier eBooks de Raktar |"
Write-Host ("-" * 43)

$src = "\\raktar.local\backup\HX90\eBooks"
$dst = "D:\Francois\eBooks"
robocopy $src $dst /E /M /ZB /SL /SJ /MT /NP
#endregion
