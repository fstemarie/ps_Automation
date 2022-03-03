#-----------------------------------------------------------------------
#region Sauvegarde du dossier Services sur Raktar
# Write-Host ("-" * 43)
# Write-Host "| Sauvegarde de la config Vim sur Box.com |"
# Write-Host ("-" * 43)

# $source = "D:\Francois\vimfiles"
# $dest = "box:/backup/config/vimfiles"
# Write-Host "1- Cree le dossier de destination"
# rclone mkdir $dest
# Write-Host "2- Synchronise les documents"
# rclone sync $source $dest -P
# rclone delete box:/backup/vimfiles.timestamp
# Write-Host "3- Cree le document d'horodatage"
# rclone touch box:/backup/vimfiles.timestamp
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde du dossier Services sur Raktar
Write-Host ("-" * 42)
Write-Host "| Sauvegarde de la config Vim sur Raktar |"
Write-Host ("-" * 42)

$source = "D:\Francois\vimfiles"
$dest = "backup:/config/vimfiles"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync $source $dest -P
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/config/vimfiles.timestamp
#endregion
