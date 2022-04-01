#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de rClone sur Raktar
Write-Host ("-" * 57)
Write-Host "| Sauvegarde de la configuration de rClone sur Raktar |"
Write-Host ("-" * 57)

$source = "D:\services\rclone"
$arch = "\\raktar\backup\HX90\rclone\rclone.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-x!rclone\rclone.conf.log"
    "-mx=9"
    $arch
    $source
)
7z u @params
#endregion
