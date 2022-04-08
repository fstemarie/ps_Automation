$scripts = @(
    '7zip\keepass.bkp.ps1'
    '7zip\nodered.bkp.ps1'
    '7zip\ungit.bkp.ps1'
    '7zip\vimfiles.bkp.ps1'
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Wait-Job
