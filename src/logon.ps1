Start-Service -Name '*rclone_cloud'
while ((Get-Service -Name '*rclone_cloud').Status -ne 'Running') {
    Start-Sleep -Seconds 2
}

& (Join-Path $PSScriptRoot 'keepassxc.ps1')
& (Join-Path $PSScriptRoot 'credentials.ps1')
