#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 41)
Write-Host "| Sauvegarde du dossier ungit sur Storj |"
Write-Host ("-" * 41)

$src = "D:\services\ungit"
$params = @(
    '--tag=ungit'
    '--verbose'
    '--exclude=node_modules'
    $src
)
restic backup @params
