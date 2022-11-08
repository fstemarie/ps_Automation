& $PSScriptRoot\restic\development.bkp.ps1
& $PSScriptRoot\restic\documents.bkp.ps1
restic prune

$scripts = @(
    '7zip\documents.bkp.ps1'    
    '7zip\development.bkp.ps1'
)
foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Receive-Job -Wait
