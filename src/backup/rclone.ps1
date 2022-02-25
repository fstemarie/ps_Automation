#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de rClone sur Box.com
Write-Host ("-" * 58)
Write-Host "| Sauvegarde de la configuration de rClone sur Box.com |"
Write-Host ("-" * 58)

$source = "D:/services/rclone"
$dest = "box:/backup/config/rclone"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync $source $dest -P
rclone deletefile box:/backup/config/rclone.timestamp
Write-Host "3- Cree le document d'horodatage"
rclone touch box:/backup/config/rclone.timestamp
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de rClone sur Raktar
Write-Host ("-" * 57)
Write-Host "| Sauvegarde de la configuration de rClone sur Raktar |"
Write-Host ("-" * 57)

$source = "D:/services/rclone"
$dest = "backup:/config/rclone"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync $source $dest -P
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/config/rclone.timestamp
#endregion
