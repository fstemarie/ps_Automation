$scripts = @(
    'documents.ps1'
    'eBooks.ps1'
    'keepass.ps1'
    'node-red.ps1'
    'services.ps1'
    'vimfiles.ps1'
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Wait-Job
