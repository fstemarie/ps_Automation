#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 44)
Write-Host "| Sauvegarde du dossier node-red sur Storj |"
Write-Host ("-" * 44)

$src = "D:\services\node-red"
$params = @(
    '--verbose'
    '--exclude=node_modules'
    $src
)
restic backup @params
