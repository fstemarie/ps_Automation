
#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Box.com
# Write-Host ("-" * 44)
# Write-Host "| Sauvegarde du dossier eBooks sur Box.com |"
# Write-Host ("-" * 44)

# $source = "D:/Francois/eBooks"
# $dest = "box:/backup/eBooks"
# Write-Host "1- Cree le dossier de destination"
# rclone mkdir $dest
# Write-Host "2- Synchronise les documents"
# rclone sync $source $dest
# rclone delete box:/backup/eBooks.timestamp
# Write-Host "3- Cree le document d'horodatage"
# rclone touch  box:/backup/eBooks.timestamp
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host ("-" * 43)
Write-Host "| Sauvegarde du dossier eBooks sur Raktar |"
Write-Host ("-" * 43)

$source = "D:/Francois/eBooks"
$dest = "backup:/eBooks"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone sync $source $dest -P
rclone delete backup:/eBooks.timestamp
Write-Host "3- Cree le document d'horodatage"
rclone touch  backup:/eBooks.timestamp
#endregion
