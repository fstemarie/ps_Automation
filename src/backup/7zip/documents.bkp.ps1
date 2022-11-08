Start-Transcript `
    -Path D:\automation\log\documents.7zip.log `
    -Append -IncludeInvocationHeader

#-----------------------------------------------------------------------
#region Sauvegarde du dossier documents sur Raktar
Write-Host "----------------------------------------------"
Write-Host "| Sauvegarde du dossier documents sur Raktar |"
Write-Host "----------------------------------------------"

$src = "D:\Francois\Documents"
$dst = "\\raktar.local\backup\HX90\documents"
$arc = "$dst\documents.7z"
# Creation du fichier incremental
$inc = "$dst\documents.$(Get-Date -Format FileDateTime).7z"
if (Test-Path -Path $arc -PathType Leaf) {
    $params = @(
        "-u-"
        "-up1q1r3x1y1z0w1!$inc"
        "-xr!Development"
        "-mx=9"
        $arc
        $src
    )
    7z u @params
}

# Mise a jour de la sauvegarde complete
$params = @(
    "-up0q0r2x2y2z1w2"
    "-xr!Development"
    "-mx=9"
    $arc
    $src
)
7z u @params
#endregion

Stop-Transcript
