Write-Host "------------------------------------------"
Write-Host "| Preparing credentials for raktar.local |"
Write-Host "------------------------------------------"

. D:\applications\KeePassCommander\KeePassEntry.ps1

$i = 10
while (-not $creds) {
    if ($i-- -eq 0) { exit }
    $creds = KeePassEntry "raktar.local - francois"
    Start-Sleep -Seconds 2
    Write-Host "Here!"
}

if ($creds) {
    net use \\raktar.local\audio        /USER:francois $($creds.password)
    net use \\raktar.local\backup       /USER:francois $($creds.password)
    net use \\raktar.local\copper       /USER:francois $($creds.password)
    net use \\raktar.local\elements     /USER:francois $($creds.password)
    net use \\raktar.local\emerald      /USER:francois $($creds.password)
    net use \\raktar.local\mybook       /USER:francois $($creds.password)
    net use \\raktar.local\slim         /USER:francois $($creds.password)
    net use \\raktar.local\storage      /USER:francois $($creds.password)
    net use \\raktar.local\tangerine    /USER:francois $($creds.password)
    net use \\raktar.local\videos       /USER:francois $($creds.password)
}
