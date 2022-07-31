#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 45)
Write-Host "| Recuperation du dossier nodered sur Storj |"
Write-Host ("-" * 45)

$dst = "D:\services\node-red"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=nodered'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
Move-Item -Path "D:\D\services" -Destination "D:\" -Force
Remove-Item -Path "D:\D"
