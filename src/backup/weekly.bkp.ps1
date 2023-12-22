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
        --user :tk_nfdourudvnssb58p2oyvuc3hqmxek `
        -H "title: hx90 weekly backup report" `
        "https://ntfy.falarie.duckdns.org/backup_hx90"
}

main
