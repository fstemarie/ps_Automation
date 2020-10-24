$source = "D:\automation"
$dest = "box:/backup/config/automation"
rclone mkdir $dest
rclone sync $source $dest -P
rclone touch box:/backup/config/automation.timestamp

$source = "D:\automation"
$dest = "backup:/config/automation"
rclone mkdir $dest
rclone sync $source $dest -P
rclone touch backup:/config/automation.timestamp
