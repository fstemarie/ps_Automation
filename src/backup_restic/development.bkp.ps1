#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 47)
Write-Host "| Sauvegarde du dossier development sur Storj |"
Write-Host ("-" * 47)

$src = "D:\Francois\Documents\Development"
$params = @(
    '--verbose'
    '--exclude=.venv'
    '--exclude=node_modules'
    $src
)
restic backup @params
