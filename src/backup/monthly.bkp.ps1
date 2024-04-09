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
        -H "title: hx90 monthly backup report" `
        ntfy.sh/backup_hx90_CtSuPrvjeCEuckcZ
}

main
