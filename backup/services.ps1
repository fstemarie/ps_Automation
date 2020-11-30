$source = "D:\services"
$dest = "backup:/config/services"
rclone sync -P $source $dest
rclone delete backup:/config/services.timestamp
rclone touch backup:/config/services.timestamp
