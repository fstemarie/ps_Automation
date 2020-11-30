$source = "D:\Francois\Documents"
$dest = "box:/backup/Documents"
rclone sync $source $dest -P --exclude .venv/** --delete-excluded
rclone delete box:/backup/Documents.timestamp
rclone touch box:/backup/Documents.timestamp --localtime

$dest = "storage:/documents"
rclone sync $source $dest -P --exclude .venv/** --delete-excluded
rclone delete storage:/Documents.timestamp
rclone touch storage:/Documents.timestamp
