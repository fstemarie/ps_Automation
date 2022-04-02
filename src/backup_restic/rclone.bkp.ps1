#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 42)
Write-Host "| Sauvegarde du dossier rclone sur Storj |"
Write-Host ("-" * 42)

$src = "D:\services\rclone"
$params = @(
    '--verbose'
    $src
)
restic backup @params
