$scripts = @(
    'robocopy\eBooks.bkp.ps1'
    'restic\rclone.bkp.ps1'
    'restic\keepass.bkp.ps1'
    'restic\nodered.bkp.ps1'
    'restic\vimfiles.bkp.ps1'
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Receive-Job -Wait
