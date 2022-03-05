#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Box.com
# Write-Host ("-" * 47)
# Write-Host "| Sauvegarde du dossier documents sur Box.com |"
# Write-Host ("-" * 47)

# $source = "D:/Francois/Documents"
# $dest = "box:/backup/Documents"
# Write-Host "1- Cree le dossier de destination"
# rclone mkdir $dest
# Write-Host "2- Synchronise les documents"
# rclone sync $source $dest -P --exclude=/Development/ --delete-excluded --ignore-case
# rclone delete box:/backup/Documents.timestamp
# Write-Host "3- Cree le document d'horodatage"
# rclone touch box:/backup/Documents.timestamp --localtime
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host ("-" * 47)
Write-Host "| Sauvegarde du dossier documents sur Raktar |"
Write-Host ("-" * 47)

$source = "D:/Francois/Documents"
$dest = "backup:/documents"
rclone sync $source $dest -P --exclude=/Development/**
rclone delete backup:/Documents.timestamp
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/Documents.timestamp
#endregion
