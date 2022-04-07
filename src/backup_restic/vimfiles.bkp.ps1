#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 42)
Write-Host "| Sauvegarde du dossier ungit sur Storj |"
Write-Host ("-" * 42)

$src = "D:\Francois\vimfiles"
$params = @(
    '--tag=vimfiles'
    '--verbose'
    $src
)
restic backup @params
