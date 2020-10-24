# Efface le fichier laisse derriere lors d'un crash de Keepass et
# qui empeche de demarrer Keepass a nouveau

$file = "D:\PortableApps.com\PortableApps\KeePassProPortable\Data\PortableApps.comLauncherRuntimeData-KeePassProPortable.ini"
Remove-Item $file	-Force -ErrorAction SilentlyContinue
