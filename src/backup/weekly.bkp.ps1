& $PSScriptRoot\restic\rclone.bkp.ps1
& $PSScriptRoot\restic\nodered.bkp.ps1
& $PSScriptRoot\restic\vimfiles.bkp.ps1
& $PSScriptRoot\restic\eBooks.bkp.ps1
restic prune

& $PSScriptRoot\robocopy\eBooks.bkp.ps1
& $PSScriptRoot\7zip\rclone.bkp.ps1
& $PSScriptRoot\7zip\keepass.bkp.ps1
& $PSScriptRoot\7zip\nodered.bkp.ps1
& $PSScriptRoot\7zip\vimfiles.bkp.ps1
