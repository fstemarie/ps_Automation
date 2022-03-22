#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host ("-" * 47)
Write-Host "| Sauvegarde du dossier documents sur Raktar |"
Write-Host ("-" * 47)

$source = "D:\Francois\Documents"
$dest = "\\raktar\backup\HX90\documents"
$arch = "$dest\documents.7z"

# Creation du fichier incremental
$incr = "$dest\documents.$(Get-Date -Format FileDateTime).7z"
if (Test-Path -Path $arch -PathType Leaf) {
    $params = @(
        "-u-"
        "-up1q1r3x1y1z0w1!$incr"
        "-xr!Development"
        "-mx=9"
        $arch
        $source
    )
    7z u @params
}

# Mise a jour de la sauvegarde complete
$params = @(
    "-up0q0r2x2y2z1w2"
    "-xr!Development"
    "-mx=9"
    $arch
    $source
)
7z u @params
#endregion
