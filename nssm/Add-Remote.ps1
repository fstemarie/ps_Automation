. D:\automation\tools\Add-NetworkLocation.ps1

switch ($args[0].ToLower()) {
	"box" {
		Write-Host "Adding Box remote"
		Add-NetworkLocation -Name "+Box" -Target "\\localhost@45000\DavWWWRoot\"
		New-Item -Force -ItemType SymbolicLink -Path "D:\remotes" -Name "Box" -Target "\\localhost@45000\DavWWWRoot\" | Out-Null
	}
	"google" {
		Write-Host "Adding Google remote"
		Add-NetworkLocation -Name "+Google" -Target "\\localhost@45001\DavWWWRoot\"
		New-Item -Force -ItemType SymbolicLink -Path "D:\remotes" -Name "Google" -Target "\\localhost@45001\DavWWWRoot\" | Out-Null
	}
	"onedrive" {
		Write-Host "Adding OneDrive remote"
		Add-NetworkLocation -Name "+OneDrive" -Target "\\localhost@45002\DavWWWRoot\"
		New-Item -Force -ItemType SymbolicLink -Path "D:\remotes" -Name "OneDrive" -Target "\\localhost@45002\DavWWWRoot\" | Out-Null
	}
}	
