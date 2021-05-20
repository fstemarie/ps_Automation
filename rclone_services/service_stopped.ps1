. D:\automation\tools\Remove-NetworkLocation.ps1

switch ($args[0].ToLower()) {
	"box" {
		Start-Transcript -Path 'D:\services\rclone_box\service_stopped.txt' -UseMinimalHeader
		Write-Output "Removing Box remote"
		Remove-Item -Force -Path "D:\remotes\Box" -ErrorAction SilentlyContinue
		Remove-NetworkLocation "+Box"
		Remove-Item -Force -Path "D:\services\rclone_box\running" -ErrorAction SilentlyContinue
		Stop-Transcript
	}
	"google" {
		Start-Transcript -Path 'D:\services\rclone_google\service_stopped.txt' -UseMinimalHeader
		Write-Output "Removing Google remote"
		Remove-Item -Force -Path "D:\remotes\Google" -ErrorAction SilentlyContinue
		Remove-NetworkLocation "+Google"
		Remove-Item -Force -Path "D:\services\rclone_google\running" -ErrorAction SilentlyContinue
		Stop-Transcript
	}
	"onedrive" {
		Start-Transcript -Path 'D:\services\rclone_onedrive\service_stopped.txt' -UseMinimalHeader
		Write-Output "Removing OneDrive remote"
		Remove-Item -Force -Path "D:\remotes\OneDrive" -ErrorAction SilentlyContinue
		Remove-NetworkLocation "+OneDrive"
		Remove-Item -Force -Path "D:\services\rclone_onedrive\running" -ErrorAction SilentlyContinue
		Stop-Transcript
	}
}
Remove-Item -Path D:\remotes -ErrorAction SilentlyContinue
