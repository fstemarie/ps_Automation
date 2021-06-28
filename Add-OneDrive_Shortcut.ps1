. .\tools\Add-Shortcut.ps1

Write-Output "Adding OneDrive network Link"

$DesktopIniContent = @"
[.ShellClassInfo]
CLSID2={0AFACED1-E828-11D1-9187-B532F1E9575D}
Flags=2
"@

$NlPath = "C:\Users\francois\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
$Nl = (Join-Path -Path "$NlPath" -ChildPath "+OneDrive")
Remove-Item -Force -Path $Nl -ErrorAction SilentlyContinue -Recurse
New-Item -Force -ItemType Directory -Path $Nl
Set-ItemProperty -Path $Nl -Name Attributes -Value ([System.IO.FileAttributes]::System)
$DesktopIni = New-Item -Force -ItemType File -Path (Join-Path -Path $Nl -ChildPath "desktop.ini")
Add-Content -Path $DesktopIni.FullName -Value $DesktopIniContent
Add-Shortcut -Path $Nl -Name "target.lnk" -Target "\\d.docs.live.net\DavWWWRoot\D564C2B3A5C2059E"
