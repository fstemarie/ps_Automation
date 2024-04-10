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
        -H "title: hx90 daily backup report" `
        -H "priority: low" `
        -H "markdown: yes" `
        https://ntfy.sh/backup_CtSuPrvjeCEuckcZ
}

main
