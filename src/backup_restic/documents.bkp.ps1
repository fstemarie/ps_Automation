#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 45)
Write-Host "| Sauvegarde du dossier documents sur Storj |"
Write-Host ("-" * 45)

$src = "D:\Francois\Documents"
$params = @(
    '--verbose'
    '--exclude=Development'
    $src
)
restic backup @params
