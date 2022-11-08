Start-Transcript `
    -Path D:\automation\log\eBooks.robocopy.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host "-------------------------------------------"
Write-Host "| Sauvegarde du dossier eBooks sur Raktar |"
Write-Host "-------------------------------------------"

$src = "D:\Francois\eBooks"
$dst = "\\raktar.local\backup\HX90\eBooks"
# robocopy $src $dst /E /FFT /Z /M /SL /SJ /MT /NP /R:10 /W:10 /COPY:DT
robocopy $src $dst /MIR /FFT /Z /M /SL /SJ /MT /NP /R:10 /W:10 /COPY:DT
#endregion

Stop-Transcript
