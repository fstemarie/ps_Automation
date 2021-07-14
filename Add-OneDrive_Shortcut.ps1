Write-Output "Adding OneDrive network Link"

#region Ajoute un raccourcis
function Add-Shortcut{
	[CmdletBinding()]
	param (
		[parameter(Mandatory)]
		[System.IO.FileInfo] $Path,
		[parameter(Mandatory)]
		[validateScript({ValidateFileName($_)})]
		[string] $Name,
		[parameter(Mandatory)]
		[System.IO.FileInfo] $Target
	)

	$shell = New-Object -ComObject WScript.Shell
	$lnkFileName = (Join-Path -Path $Path -ChildPath $Name)
	$lnkFile = $shell.CreateShortcut($LnkFileName)
	$lnkFile.TargetPath = $Target
	try {
		$lnkFile.Save()
	}
	catch [System.Management.Automation.MethodInvocationException] {
		Write-Error "Access denied"
	}
}

function ValidateFileName{
	param($fileName)
	$indexOfInvalidChar = $fileName.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars())
	# IndexOfAny() returns the value -1 to indicate no such character was found
	if ($indexOfInvalidChar -ne -1) {
		Write-Error "A file name can't contain any of the following characters \/:*?`"<>|"
		$False
	}
	else {
		$True
	}
}
#endregion

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
