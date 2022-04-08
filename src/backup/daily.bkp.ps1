$scripts = @(
    'restic\development.bkp.ps1'
    'restic\documents.bkp.ps1'
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Wait-Job
