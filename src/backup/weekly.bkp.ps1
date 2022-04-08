$scripts = @(
    'robocopy\eBooks.bkp.ps1'
    '7zip\rclone.bkp.ps1'
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Receive-Job -Wait
