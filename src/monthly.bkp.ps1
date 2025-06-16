$scripts = @(
    "backup/restic/rclone.bkp.ps1",
    "backup/restic/vimfiles.bkp.ps1",
    "backup/robocopy/eBooks.bkp.ps1",
    "backup/7zip/automation.bkp.ps1",
    "backup/7zip/rclone.bkp.ps1",
    "backup/7zip/vimfiles.bkp.ps1"
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
        -H "title: 💾hx90 monthly backup report" `
        -H "priority: low" `
        -H "markdown: yes" `
        https://ntfy.sh/automation_ewNXGlvorS6g8NUr
}

main
