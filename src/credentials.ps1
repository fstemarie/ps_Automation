Write-Host ("-" * 42)
Write-Host "| Preparing credentials for raktar.local |"
Write-Host ("-" * 42)

. D:\applications\KeePassCommander\KeePassEntry.ps1
$creds = KeePassEntry "raktar.local - francois"

net use \\raktar.local\Copper       /USER:francois $($creds.password)
net use \\raktar.local\Copper_Audio /USER:francois $($creds.password)
net use \\raktar.local\Elements     /USER:francois $($creds.password)
net use \\raktar.local\Emerald      /USER:francois $($creds.password)
net use \\raktar.local\Mauve        /USER:francois $($creds.password)
net use \\raktar.local\Mauve_Audio  /USER:francois $($creds.password)
net use \\raktar.local\MyBook       /USER:francois $($creds.password)
net use \\raktar.local\Slim         /USER:francois $($creds.password)
net use \\raktar.local\Storage      /USER:francois $($creds.password)
net use \\raktar.local\Tangerine    /USER:francois $($creds.password)
net use \\raktar.local\Videos       /USER:francois $($creds.password)
net use \\raktar.local\OMV          /USER:francois $($creds.password)
net use \\raktar\Copper             /USER:francois $($creds.password)
net use \\raktar\Copper_Audio       /USER:francois $($creds.password)
net use \\raktar\Elements           /USER:francois $($creds.password)
net use \\raktar\Emerald            /USER:francois $($creds.password)
net use \\raktar\Mauve              /USER:francois $($creds.password)
net use \\raktar\Mauve_Audio        /USER:francois $($creds.password)
net use \\raktar\MyBook             /USER:francois $($creds.password)
net use \\raktar\Slim               /USER:francois $($creds.password)
net use \\raktar\Storage            /USER:francois $($creds.password)
net use \\raktar\Tangerine          /USER:francois $($creds.password)
net use \\raktar\Videos             /USER:francois $($creds.password)
net use \\raktar\OMV                /USER:francois $($creds.password)
