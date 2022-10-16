Write-Host ("-" * 43)
Write-Host "| Prefetching password for Github GPG key |"
Write-Host ("-" * 43)

. D:\applications\KeePassCommander\KeePassEntry.ps1

gpg-connect-agent UPDATESTARTUPTTY /bye

$keepass = Get-Process -Name KeePass -ErrorAction SilentlyContinue
if (-not ($keepass)) {
    Write-Error "KeePass process not found"
    Exit
}
$gpgagent = Get-Process -Name gpg-agent -ErrorAction SilentlyContinue
if (-not ($gpgagent)) {
    Write-Error "gpg-agent process not found"
    Exit
}

$entry = KeePassEntry "Github.com"
gpg-preset-passphrase --preset --passphrase $entry.password 2BADB96BFA63C75C