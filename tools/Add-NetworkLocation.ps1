#https://community.spiceworks.com/topic/2222919-add-a-network-location-via-powershell

. $PSScriptRoot\Add-Shortcut.ps1
function Add-NetworkLocation {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[string]$Name,
		[Parameter(Mandatory)]
		[string]$Target
	)

	$DesktopIniContent = @"
[.ShellClassInfo]
CLSID2={0AFACED1-E828-11D1-9187-B532F1E9575D}
Flags=2
"@

	$NlPath = "C:\Users\francois\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
	$Nl = (Join-Path -Path "$NlPath" -ChildPath "$Name")
	Remove-Item -Force -Path $Nl -ErrorAction SilentlyContinue 
	New-Item -Force -ItemType Directory -Path $Nl
	Set-ItemProperty -Path $Nl -Name Attributes -Value ([System.IO.FileAttributes]::System)
	$DesktopIni = New-Item -Force -ItemType File -Path (Join-Path -Path $Nl -ChildPath "desktop.ini")
	Add-Content -Path $DesktopIni.FullName -Value $DesktopIniContent
	Add-Shortcut -Path $Nl -Name "target.lnk" -Target $Target
}
