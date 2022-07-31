#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 49)
Write-Host "| Recuperation du dossier development sur Storj |"
Write-Host ("-" * 49)

$dst = "D:\francois\Documents\Development"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=development'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
Move-Item -Path "D:\D\francois" -Destination "D:\" -Force
Remove-Item -Path "D:\D"
