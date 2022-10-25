$scripts = @(
)

foreach ($script in $scripts) {
    Start-Job -Name  $script -FilePath "$PSScriptRoot\$script"
}
Get-Job | Receive-Job -Wait
