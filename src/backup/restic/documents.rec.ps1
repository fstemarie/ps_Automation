#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 47)
Write-Host "| Recuperation du dossier documents sur Storj |"
Write-Host ("-" * 47)

$dst = "D:\francois\Documents"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=documents'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
Move-Item -Path "D:\D\francois" -Destination "D:\" -Force
Remove-Item -Path "D:\D"
