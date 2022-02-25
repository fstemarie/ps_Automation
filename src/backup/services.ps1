#-----------------------------------------------------------------------
#region Sauvegarde du dossier Services sur Box.com
Write-Host ("-" * 46)
Write-Host "| Sauvegarde du dossier Services sur Box.com |"
Write-Host ("-" * 46)

$source = "D:/services"
$dest = "backup:/config/services"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync -P $source $dest
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/config/services.timestamp
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde du dossier Services sur Raktar
Write-Host ("-" * 45)
Write-Host "| Sauvegarde du dossier Services sur Raktar |"
Write-Host ("-" * 45)

$source = "D:/services"
$dest = "backup:/config/services"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync -P $source $dest
rclone delete backup:/config/services.timestamp
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/config/services.timestamp
#endregion
