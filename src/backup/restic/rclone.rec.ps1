#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 44)
Write-Host "| Recuperation du dossier rclone sur Storj |"
Write-Host ("-" * 44)

$dst = "D:\services\rclone"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=rclone'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
Move-Item -Path "D:\D\services" -Destination "D:\" -Force
Remove-Item -Path "D:\D"
