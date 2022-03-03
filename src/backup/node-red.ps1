#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de Node-RED sur Box.com
# Write-Host ("-" * 58)
# Write-Host "| Sauvegarde de la configuration de Node-RED sur Box.com |"
# Write-Host ("-" * 58)

# $source = "D:/services/node-red/settings.js"
# $dest = "box:/backup/config/node-red"
# Write-Host "1- Cree le dossier de destination"
# rclone mkdir $dest
# Write-Host "2- Synchronise les documents"
# rclone sync $source $dest -P
# rclone delete box:/backup/config/node-red.timestamp
# Write-Host "3- Cree le document d'horodatage"
# rclone touch box:/backup/config/node-red.timestamp
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de Node-RED sur Raktar
Write-Host ("-" * 57)
Write-Host "| Sauvegarde de la configuration de Node-RED sur Raktar |"
Write-Host ("-" * 57)

$source = "D:/services/node-red"
$dest = "backup:/config/node-red"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync $source $dest -P --exclude=/node-red/node_modules/**
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/config/node-red.timestamp
#endregion
