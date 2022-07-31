#----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Storj
Write-Host ("-" * 46)
Write-Host "| Recuperation du dossier vimfiles sur Storj |"
Write-Host ("-" * 46)

$dst = "D:\francois\vimfiles"
if (Test-Path -Path $dst -PathType Container) {
    Move-Item -Path $dst -Destination "$dst.$(Get-Date -UFormat %s)"
}

$params = @(
    '--tag=vimfiles'
    '--verbose'
    '--target=D:\'
)
restic restore latest @params
Move-Item -Path "D:\D\francois" -Destination "D:\" -Force
Remove-Item -Path "D:\D"
