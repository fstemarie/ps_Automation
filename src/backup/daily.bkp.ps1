$scripts = @(
    "restic/development.bkp.ps1",
    "restic/documents.bkp.ps1",
    "7zip/development.bkp.ps1",
    "7zip/documents.bkp.ps1"
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
        -H "title: hx90 daily backup report" `
        "https://ntfy.falarie.duckdns.org/backup_hx90"
}

main
