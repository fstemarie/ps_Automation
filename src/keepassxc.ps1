# This will ALWAYS work if the env var exists (user or machine scope)
if (-not $env:KEEPASSXC_KEY) {
    $env:KEEPASSXC_KEY = Read-Host "KeePassXC master password" -AsSecureString | ConvertFrom-SecureString
    [Environment]::SetEnvironmentVariable("KEEPASSXC_KEY", $env:KEEPASSXC_KEY, "User")
    Write-Host "Password saved encrypted to permanent user environment variable." -ForegroundColor Green
}

# Decrypt to plaintext (yes, this is the only moment it's plaintext)
[Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
        (${env:KEEPASSXC_KEY} | ConvertTo-SecureString)
    )
) | keepassxc "X:\keepass\Passwords.kdbx" --pw-stdin
