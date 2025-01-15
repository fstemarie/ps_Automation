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
        -H "priority: low" `
        -H "markdown: yes" `
        https://ntfy.sh/backup_CtSuPrvjeCEuckcZ
}

main
