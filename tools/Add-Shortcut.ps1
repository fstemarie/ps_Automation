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
