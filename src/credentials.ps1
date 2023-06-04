Write-Host "----------------------------------------"
Write-Host " Preparing credentials for raktar.local "
Write-Host "----------------------------------------"

. D:\applications\KeePassCommander\KeePassEntry.ps1

$i = 10
while (!$creds) {
    if ($i-- -eq 0) { exit }
    $creds = KeePassEntry "raktar.local - francois"
    Start-Sleep -Seconds 2
}

net use \\raktar.local\audio    /USER:francois $($creds.password)
net use \\raktar.local\backup   /USER:francois $($creds.password)
net use \\raktar.local\elements /USER:francois $($creds.password)
net use \\raktar.local\emerald  /USER:francois $($creds.password)
net use \\raktar.local\jade     /USER:francois $($creds.password)
net use \\raktar.local\ruby     /USER:francois $($creds.password)
net use \\raktar.local\sapphire /USER:francois $($creds.password)
net use \\raktar.local\storage  /USER:francois $($creds.password)
net use \\raktar.local\ufc      /USER:francois $($creds.password)
net use \\raktar.local\videos   /USER:francois $($creds.password)
