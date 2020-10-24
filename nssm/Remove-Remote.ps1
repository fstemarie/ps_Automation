. D:\automation\tools\Remove-NetworkLocation.ps1

switch ($args[0].ToLower()) {
	"box" {
		Write-Host "Removing Box remote"
		Remove-Item -Force -Path "D:\remotes\Box" -ErrorAction SilentlyContinue
		Remove-NetworkLocation "+Box"
	}
	"google" {
		Write-Host "Removing Google remote"
		Remove-Item -Force -Path "D:\remotes\Google" -ErrorAction SilentlyContinue
		Remove-NetworkLocation "+Google"
	}
	"onedrive" {
		Write-Host "Removing OneDrive remote"
		Remove-Item -Force -Path "D:\remotes\OneDrive" -ErrorAction SilentlyContinue
		Remove-NetworkLocation "+OneDrive"
	}
}
Remove-Item -Path D:\remotes -ErrorAction SilentlyContinue
