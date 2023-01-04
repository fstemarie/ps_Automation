$keepass = "D:\Francois\Documents\KeePass\gdrive - g"
$dst = "\\raktar.local\backup\HX90\keepass"
$arc = Join-Path $dst "keepass.$(Get-Date -Format FileDateTime).7z"

$params = @{
    Path                    = Join-Path $env:APPDATA "log" "keepass.7zip.log"
    Append                  = $true
    IncludeInvocationHeader = $true
}
Start-Transcript @params

#-----------------------------------------------------------------------
# Sauvegarde des documents Keepass sur Raktar
Write-Host "┌────────────────────────────────────────────┐"
Write-Host "│ Sauvegarde de la config KeePass sur Raktar │"
Write-Host "└────────────────────────────────────────────┘"

$params = @(
    "-mx=9"
    $arc
    "${env:APPDATA}\KeePass\KeePass.config.xml"
    "${keepass}\Passwords.kdbx"
    "${keepass}\Discarded.kdbx"
)

Push-Location -Path C:\
7z u @params
Pop-Location

$nb_max = 5
$bkps = Get-Item (Join-Path $dst "keepass.*.7z") | Sort-Object
if ($bkps.Count -gt $nb_max) {
    Write-Host "Enleve les fichiers de sauvegardes de trop"
    $nb_del = $bkps.Count - $nb_max
    Remove-Item -Path ($bkps | Select-Object -First $nb_del)
}

Stop-Transcript
