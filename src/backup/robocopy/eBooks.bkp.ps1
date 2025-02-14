# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
$src = "D:\Francois\Documents\eBooks"
$dst = "\\raktar.local\backup\HX90\eBooks"

if (!$env:AUTOMATION -Or !(Test-Path "$env:AUTOMATION")) {
    Write-Error "eBooks.bkp.ps1 -- AUTOMATION empty or invalid. Cannot proceed"
    exit 1
}

$params = @{
    Path = Join-Path $env:AUTOMATION "log" "eBooks.robocopy.log"
    Append = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host "`n`n"
Write-Host "-------------------------------------------"
Write-Host " Backup of the eBooks folder with robocopy "
Write-Host "-------------------------------------------"

# robocopy $src $dst /E /FFT /Z /M /SL /SJ /MT /NP /R:10 /W:10 /COPY:DT
robocopy $src $dst /MIR /FFT /Z /M /SL /SJ /MT /NP /R:10 /W:10 /COPY:DT
#endregion

Stop-Transcript
