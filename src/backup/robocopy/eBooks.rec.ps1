#-----------------------------------------------------------------------
#region Sauvegarde du dossier eBooks sur Raktar
Write-Host "┌──────────────────────────────────────────┐"
Write-Host "│ Recuperation du dossier eBooks de Raktar │"
Write-Host "└──────────────────────────────────────────┘"

$src = "\\raktar.local\backup\HX90\eBooks"
$dst = "D:\francois\Documents\eBooks"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

robocopy $src $dst /E
# robocopy $src $dst /MIR
#endregion
