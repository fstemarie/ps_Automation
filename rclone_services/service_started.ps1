. D:\automation\tools\Add-NetworkLocation.ps1

switch ($args[0].ToLower()) {
	"box" {
		Start-Transcript -Path 'D:\services\rclone_box\service_started.txt' -UseMinimalHeader
		Write-Output "Adding Box remote"
		Add-NetworkLocation -Name "+Box" -Target "\\localhost@45000\DavWWWRoot\"
		New-Item -Force -ItemType SymbolicLink -Path "D:\remotes" -Name "Box" -Target "\\localhost@45000\DavWWWRoot\"
		New-Item -Force -ItemType File -Path "D:\services\rclone_box\running"
		Stop-Transcript
	}
	"google" {
		Start-Transcript -Path 'D:\services\rclone_google\service_started.txt' -UseMinimalHeader
		Write-Output "Adding Google remote"
		Add-NetworkLocation -Name "+Google" -Target "\\localhost@45001\DavWWWRoot\"
		New-Item -Force -ItemType SymbolicLink -Path "D:\remotes" -Name "Google" -Target "\\localhost@45001\DavWWWRoot\" | Out-Null
		New-Item -Force -ItemType File -Path "D:\services\rclone_google\running"
		Stop-Transcript
	}
	"onedrive" {
		Start-Transcript -Path 'D:\services\rclone_onedrive\service_started.txt' -UseMinimalHeader
		Write-Output "Adding OneDrive remote"
		Add-NetworkLocation -Name "+OneDrive" -Target "\\localhost@45002\DavWWWRoot\"
		New-Item -Force -ItemType SymbolicLink -Path "D:\remotes" -Name "OneDrive" -Target "\\localhost@45002\DavWWWRoot\" | Out-Null
		New-Item -Force -ItemType File -Path "D:\services\rclone_onedrive\running"
		Stop-Transcript
	}
}	
