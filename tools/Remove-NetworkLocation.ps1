function Remove-NetworkLocation {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[string]$Name
	)

	$NlPath = "C:\Users\francois\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
	$Nl = (Join-Path -Path $NlPath -ChildPath $Name)
	Remove-Item -Force -Recurse -Path $Nl -ErrorAction SilentlyContinue
}
