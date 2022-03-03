#-----------------------------------------------------------------------
#region Sauvegarde des documents Keepass sur Box.com
# Write-Host ("-" * 47)
# Write-Host "| Sauvegarde de la config KeePass sur Box.com |"
# Write-Host ("-" * 47)

# Start-Sleep -Seconds 3
# $source = $env:APPDATA + "\KeePass\KeePass.config.xml"
# $dest = "box:/backup/config/KeePass"
# Write-Host "1- Cree le dossier de destination"
# rclone mkdir $dest
# Write-Host "2- Synchronise les documents"
# rclone copy $source $dest -P
# $source = $env:APPDATA + "\KeePass\KeeAnywhere.Accounts.json"
# rclone copy $source $dest -P
# rclone delete box:/backup/config/KeePass.timestamp
# Write-Host "3- Cree le document d'horodatage"
# rclone touch  box:/backup/config/KeePass.timestamp
#endregion

#-----------------------------------------------------------------------
#region Sauvegarde des documents Keepass sur Raktar
Write-Host ("-" * 46)
Write-Host "| Sauvegarde de la config KeePass sur Raktar |"
Write-Host ("-" * 46)

Start-Sleep -Seconds 3
$source = $env:APPDATA + "\KeePass\KeePass.config.xml"
$dest = "backup:/config/KeePass"
Write-Host "1- Cree le dossier de destination"
rclone mkdir $dest
Write-Host "2- Synchronise les documents"
rclone copy $source $dest -P
$source = $env:APPDATA + "\KeePass\KeeAnywhere.Accounts.json"
rclone copy $source $dest -P
Write-Host "3- Cree le document d'horodatage"
rclone touch backup:/config/KeePass.timestamp
#endregion
