#-----------------------------------------------------------------------
#region Sauvegarde du dossier development sur Raktar
Write-Host ("-" * 49)
Write-Host "| Sauvegarde du dossier documents sur Raktar |"
Write-Host ("-" * 49)

$source = "D:\Francois\Documents\Development"
$dest = "\\raktar\Storage\backup\HX90\development"
# Creation du fichier incremental
$arch = "$dest\development.7z"
$incr = "$dest\development.$(Get-Date -Format FileDateTime).7z"
if (Test-Path -Path $arch -PathType Leaf) {
    $params = @(
        "-u-"
        "-up1q1r3x1y1z0w1!$incr"
        "-xr!node_modules"
        "-xr!.venv"
        "-mx=9"
        $arch
        $source
    )
    7z u @params
}

# Mise a jour de la sauvegarde complete
$params = @(
    "-up0q0r2x2y2z1w2"
    "-mx=9"
    "-xr!node_modules"
    "-xr!.venv"
    $arch
    $source
)
7z u @params
#endregion
