$source = "D:\Francois\Documents"
$dest = "box:/backup/Documents"
rclone sync -P $source $dest
rclone touch box:/backup/Documents.timestamp

$dest = "storage:/documents"
rclone sync -P $source $dest
rclone touch storage:/Documents.timestamp
