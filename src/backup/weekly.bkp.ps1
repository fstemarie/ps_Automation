$scripts = @(
    '7zip\documents.bkp.ps1'
    '7zip\development.bkp.ps1'
    'robocopy\eBooks.bkp.ps1'
    '7zip\rclone.bkp.ps1'
    '7zip\keepass.bkp.ps1'
    '7zip\nodered.bkp.ps1'
    '7zip\vimfiles.bkp.ps1'
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Wait-Job
