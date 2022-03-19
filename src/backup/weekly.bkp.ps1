$scripts = @(
    'documents.bkp.ps1'
    'development.bkp.ps1'
    'eBooks.bkp.ps1'
    'rclone.bkp.ps1'
    'keepass.bkp.ps1'
    'nodered.bkp.ps1'
    'vimfiles.bkp.ps1'
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Wait-Job
