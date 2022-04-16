$site = "http://website.com/video.m3u8"
$port = 8000
$referer = "http://referer.com"
$origin = "http://origin.com"
$original_powercfg = 23ab3542-18f8-4ddb-9822-a23d9c973020
$nosleep_powercfg = a1841308-3541-4fab-bc81-f71556f20b4a

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process pwsh.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
powercfg /setactive $nosleep_powercfg

try {
    streamlink `
        --http-header "User-Agent= Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0" `
        --http-header "Origin= $origin" `
        --http-header "Connection= keep-alive" `
        --http-header "Referer= $referer" `
        --player-external-http `
        --player-external-http-port $port `
        $site `
    best
}
finally {
    powercfg /setactive $original_powercfg
}
