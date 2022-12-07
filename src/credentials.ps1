Write-Host "------------------------------------------"
Write-Host "| Preparing credentials for raktar.local |"
Write-Host "------------------------------------------"

. D:\applications\KeePassCommander\KeePassEntry.ps1
$creds = KeePassEntry "raktar.local - francois"

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

# net use \\raktar\Copper             /USER:francois $($creds.password)
# net use \\raktar\Copper_Audio       /USER:francois $($creds.password)
# net use \\raktar\Elements           /USER:francois $($creds.password)
# net use \\raktar\Emerald            /USER:francois $($creds.password)
# net use \\raktar\MyBook             /USER:francois $($creds.password)
# net use \\raktar\Slim               /USER:francois $($creds.password)
# net use \\raktar\Storage            /USER:francois $($creds.password)
# net use \\raktar\Tangerine          /USER:francois $($creds.password)
# net use \\raktar\Videos             /USER:francois $($creds.password)
# net use \\raktar\OMV                /USER:francois $($creds.password)
