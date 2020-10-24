$source = "D:\Francois\eBooks"
$dest = "box:/backup/eBooks"
rclone sync $source $dest
rclone touch box:/backup/eBooks.timestamp

$dest = "storage:/eBooks"
rclone sync $source $dest
rclone touch storage:/eBooks.timestamp
