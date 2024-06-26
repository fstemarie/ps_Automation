$scripts = @(
    "restic/rclone.bkp.ps1",
    # "restic/nodered.bkp.ps1",
    "restic/vimfiles.bkp.ps1",
    "restic/eBooks.bkp.ps1",
    "robocopy/eBooks.bkp.ps1",
    "7zip/rclone.bkp.ps1",
    "7zip/keepass.bkp.ps1",
    # "7zip/nodered.bkp.ps1",
    "7zip/vimfiles.bkp.ps1"
)
$notifs = @()

function main {
    foreach($script in $scripts) {
        restic unlock
        & $PSScriptRoot\$script
        if ($?) {
            $notifs += "🟢 $script`n"
        } else {
            $notifs += "🔴 $script`n"
        }
        restic prune
    }

    $notifs | curl -T- `
        -H "title: hx90 weekly backup report" `
        -H "priority: low" `
        -H "markdown: yes" `
        https://ntfy.sh/backup_CtSuPrvjeCEuckcZ
}

main
