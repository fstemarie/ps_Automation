Start-Transcript `
    -Path D:\automation\log\development.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Raktar
Write-Host "------------------------------------------------"
Write-Host "| Sauvegarde du dossier development sur Raktar |"
Write-Host "------------------------------------------------"

$src = "D:\Francois\Documents\Development"
$dst = "\\raktar.local\backup\HX90\development"
# Creation du fichier incremental
$arc = "$dst\development.7z"
$inc = "$dst\development.$(Get-Date -Format FileDateTime).7z"
if (Test-Path -Path $arc -PathType Leaf) {
    $params = @(
        "-u-"
        "-up1q1r3x1y1z0w1!$inc"
        "-xr!node_modules"
        "-xr!.venv"
        "-mx=9"
        $arc
        $src
    )
    7z u @params
}

# Mise a jour de la sauvegarde complete
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    "-xr!node_modules"
    "-xr!.venv"
    $arc
    $src
)
7z u @params
#endregion

Stop-Transcript
