$source = "D:\Francois\vimfiles"
$dest = "box:/backup/config/vimfiles"
rclone mkdir $dest
rclone sync $source $dest -P
rclone touch box:/backup/vimfiles.timestamp

$source = "D:\Francois\vimfiles"
$dest = "backup:/config/vimfiles"
rclone mkdir $dest
rclone sync $source $dest -P
rclone touch backup:/config/vimfiles.timestamp
