Start-Transcript `
    -Path D:\automation\log\eBooks.robocopy.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host ("-" * 43)
Write-Host "| Sauvegarde du dossier eBooks sur Raktar |"
Write-Host ("-" * 43)

$src = "D:\Francois\eBooks"
$dst = "\\raktar.local\backup\HX90\eBooks"
robocopy $src $dst /MIR /M /SL /SJ /MT /NP
#endregion

Stop-Transcript
