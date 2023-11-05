$scripts = @()
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
        -H "title: hx90 monthly backup report" `
        "https://ntfy.falarie.duckdns.org/backup_hx90"
}

main
