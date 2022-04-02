#-----------------------------------------------------------------------
#region Sauvegarde des documents Keepass sur Raktar
Write-Host ("-" * 46)
Write-Host "| Sauvegarde de la config KeePass sur Raktar |"
Write-Host ("-" * 46)

$arch = "\\raktar\backup\HX90\keepass\keepass.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    $arch
    "${env:APPDATA}\KeePass\KeePass.config.xml"
    "${env:APPDATA}\KeePass\KeeAnywhere.Accounts.json"
)

Push-Location -Path C:\
7z u @params
rclone cat keepass:Passwords.kdbx | 7z u $arch -si"Passwords.kdbx"
rclone cat keepass:Discarded.kdbx | 7z u $arch -si"Discarded.kdbx"
Pop-Location
#endregion
