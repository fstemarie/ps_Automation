#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 37)
Write-Host "| Nettoyage des snapshots de restic |"
Write-Host ("-" * 37)

restic forget --prune --tag documents,development `
    --keep-within-daily 7d --keep-within-monthly 6m

restic forget --prune --tag nodered,rclone,ungit,vimfiles --keep-last 4 
