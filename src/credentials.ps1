Write-Host "----------------------------------------"
Write-Host " Preparing credentials for sklad "
Write-Host "----------------------------------------"

$db = "X:\keepass\Passwords.kdbx"
$entry = "sklad_B362531346"

# This will ALWAYS work if the env var exists (user or machine scope)
if (-not $env:KEEPASSXC_KEY) {
    $env:KEEPASSXC_KEY = Read-Host "KeePassXC master password" -AsSecureString | ConvertFrom-SecureString
    [Environment]::SetEnvironmentVariable("KEEPASSXC_KEY", $env:KEEPASSXC_KEY, "User")
    Write-Host "Password saved encrypted to permanent user environment variable." -ForegroundColor Green
}

# Decrypt to plaintext (yes, this is the only moment it's plaintext)

# Run the CLI command and capture output
$pass = (
    [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
            (${env:KEEPASSXC_KEY} | ConvertTo-SecureString)
        )
    ) | keepassxc-cli show --attributes password $db $entry 2>$null
)
if (! $pass) {
    Write-Error "Failed to retrieve entry. Wrong password or entry not found."
}

# Map network drives
net use \\sklad\emerald  /USER:francois $pass
net use \\sklad\opal     /USER:francois $pass
net use \\sklad\ruby     /USER:francois $pass
net use \\sklad\sapphire /USER:francois $pass
net use \\sklad\topaz    /USER:francois $pass
net use \\sklad\cloud    /USER:francois $pass
net use \\sklad\audio    /USER:francois $pass
net use \\sklad\backup   /USER:francois $pass
net use \\sklad\storage  /USER:francois $pass
net use \\sklad\video    /USER:francois $pass
