$source = "D:/Francois/eBooks"
$dest = "box:/backup/eBooks"
rclone sync $source $dest
rclone delete box:/backup/eBooks.timestamp
rclone touch  box:/backup/eBooks.timestamp

$dest = "storage:/eBooks"
rclone sync $source $dest
rclone delete storage:/eBooks.timestamp
rclone touch  storage:/eBooks.timestamp
