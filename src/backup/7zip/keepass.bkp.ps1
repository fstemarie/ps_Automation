Start-Transcript `
    -Path D:\automation\log\keepass.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde des documents Keepass sur Raktar
Write-Host ("-" * 46)
Write-Host "| Sauvegarde de la config KeePass sur Raktar |"
Write-Host ("-" * 46)

$arc = "\\raktar\backup\HX90\keepass\keepass.7z"
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    $arc
    "${env:APPDATA}\KeePass\KeePass.config.xml"
    "${env:APPDATA}\KeePass\KeeAnywhere.Accounts.json"
)

Push-Location -Path C:\
7z u @params
rclone cat keepass:Passwords.kdbx | 7z u $arc -si"Passwords.kdbx"
rclone cat keepass:Discarded.kdbx | 7z u $arc -si"Discarded.kdbx"
Pop-Location
#endregion

Stop-Transcript
