& $PSScriptRoot\restic\rclone.bkp.ps1
& $PSScriptRoot\restic\nodered.bkp.ps1
& $PSScriptRoot\restic\keepass.bkp.ps1
& $PSScriptRoot\restic\vimfiles.bkp.ps1
restic prune

$scripts = @(
    'robocopy\eBooks.bkp.ps1'
    '7zip\rclone.bkp.ps1'
    '7zip\keepass.bkp.ps1'
    '7zip\nodered.bkp.ps1'
    '7zip\vimfiles.bkp.ps1'
)
foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Receive-Job -Wait
