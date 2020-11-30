$source = "D:\Francois\vimfiles"
$dest = "box:/backup/config/vimfiles"
rclone mkdir $dest
rclone sync $source $dest -P
rclone delete box:/backup/vimfiles.timestamp
rclone touch box:/backup/vimfiles.timestamp

$source = "D:\Francois\vimfiles"
$dest = "backup:/config/vimfiles"
rclone mkdir $dest
rclone sync $source $dest -P
rclone delete backup:/config/vimfiles.timestamp
rclone touch backup:/config/vimfiles.timestamp
