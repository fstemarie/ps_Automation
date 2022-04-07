Start-Transcript `
    -Path D:\automation\log\rclone.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde de la configuration de rClone sur Raktar
Write-Host ("-" * 57)
Write-Host "| Sauvegarde de la configuration de rClone sur Raktar |"
Write-Host ("-" * 57)

$src = "D:\services\rclone"
$arc = "\\raktar\backup\HX90\rclone\rclone.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    $arc
    $src
)
7z u @params
#endregion

Stop-Transcript
