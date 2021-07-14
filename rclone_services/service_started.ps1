#-----------------------------------------------------------------------
#region Ajouter une liaison reseau
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
#endregion

# Start-Transcript -Path 'D:/services/rclone/service_started.txt' -UseMinimalHeader
switch ($args[0].ToLower()) {
	"box" {
        Write-Output "Adding Box.com remote"
        Add-NetworkLocation -Name "+Box" -Target "\\localhost@45000\DavWWWRoot\"
	}
	"google" {
        Write-Output "Adding Google remote"
		Add-NetworkLocation -Name "+Google" -Target "\\localhost@45001\DavWWWRoot\"
	}
	"onedrive" {
        Write-Output "Adding OneDrive remote"
		Add-NetworkLocation -Name "+OneDrive" -Target "\\localhost@45002\DavWWWRoot\"
	}
}
# Stop-Transcript

# New-Item -Force -ItemType File -Path "D:/services/rclone/rclone_box/running"
# New-Item -Force -ItemType File -Path "D:/services/rclone_google/running"
# New-Item -Force -ItemType File -Path "D:/services/rclone_onedrive/running"
# New-Item -Force -ItemType SymbolicLink -Path "D:/remotes" -Name "Box" -Target "\\localhost@45000\DavWWWRoot\"
# New-Item -Force -ItemType SymbolicLink -Path "D:/remotes" -Name "Google" -Target "\\localhost@45001\DavWWWRoot\" | Out-Null
# New-Item -Force -ItemType SymbolicLink -Path "D:/remotes" -Name "OneDrive" -Target "\\localhost@45002\DavWWWRoot\" | Out-Null
