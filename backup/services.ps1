$source = "D:\services"
$dest = "backup:/config/services"
rclone sync -P $source $dest
rclone touch backup:/config/services.timestamp
