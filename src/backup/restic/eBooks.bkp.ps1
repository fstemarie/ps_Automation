#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 42)
Write-Host "| Sauvegarde du dossier eBooks sur Storj |"
Write-Host ("-" * 42)

$src = "D:\Francois\eBooks"
$params = @(
    '--tag=eBooks'
    '--verbose'
    $src
)
restic backup @params
