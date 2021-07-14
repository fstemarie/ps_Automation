#-----------------------------------------------------------------------
#region Enleve une liaison reseau
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
#endregion

$service = $args[0].ToLower()
# Start-Transcript -Path "D:/services/rclone/service_stopped.log" -UseMinimalHeader
Write-Output "Removing $service remote"
Remove-NetworkLocation "+$service"
# Stop-Transcript

# Remove-Item -Force -Path "D:/remotes/$service" -ErrorAction SilentlyContinue
# Remove-Item -Force -Path "D:/services/rclone/rclone_$service/running" -ErrorAction SilentlyContinue
# Remove-Item -Path D:\remotes -ErrorAction SilentlyContinue
