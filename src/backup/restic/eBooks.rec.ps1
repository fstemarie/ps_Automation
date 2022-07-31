#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 44)
Write-Host "| Recuperation du dossier eBooks sur Storj |"
Write-Host ("-" * 44)

$dst = "D:\francois\eBooks"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=eBooks'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
Move-Item -Path "D:\D\rancois" -Destination "D:\" -Force
Remove-Item -Path "D:\D"
