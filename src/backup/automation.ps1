#-----------------------------------------------------------------------
#region Sauvegarde du dossier Automation sur Box.com
Write-Host ("-" * 48)
Write-Host "| Sauvegarde du dossier Automation sur Box.com |"
Write-Host ("-" * 48)

$source = "D:/automation"
$dest = "box:/backup/config/automation"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync $source $dest -P
rclone delete box:/backup/config/automation.timestamp
Write-Host "3- Cree le document d'horodatage"
rclone touch box:/backup/config/automation.timestamp
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde du dossier Automation sur Raktar
Write-Host ("-" * 47)
Write-Host "| Sauvegarde du dossier Automation sur Raktar |"
Write-Host ("-" * 47)

$source = "D:/automation"
$dest = "backup:/config/automation"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync $source $dest -P
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/config/automation.timestamp
#endregion
