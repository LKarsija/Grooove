# ============================================
# Grooove - Navidrome API Smoke Test
# Saves JSON examples to docs/api_examples/
# ============================================
# Run from scripts/:  Set-ExecutionPolicy -Scope Process Bypass; .\test-navidrome.ps1

$configPath = Join-Path $PSScriptRoot "config.local.ps1"
if (-not (Test-Path $configPath)) {
    Write-Error "Missing config.local.ps1 - copy config.example.ps1 to config.local.ps1 and set your password."
    exit 1
}

. $configPath

function Get-SubsonicQueryString {
    param([hashtable]$Extra = @{})

    $Params = @{}
    foreach ($Key in $Common.Keys) { $Params[$Key] = $Common[$Key] }
    foreach ($Key in $Extra.Keys) { $Params[$Key] = $Extra[$Key] }

    ($Params.GetEnumerator() | ForEach-Object {
        "{0}={1}" -f [uri]::EscapeDataString($_.Key), [uri]::EscapeDataString([string]$_.Value)
    }) -join "&"
}

function Invoke-Subsonic {
    param(
        [string]$Endpoint,
        [hashtable]$Extra = @{}
    )

    $Uri = "$Base/$Endpoint" + "?" + (Get-SubsonicQueryString -Extra $Extra)
    Invoke-RestMethod -Uri $Uri -Method Get
}

$Salt = "grooove"
$Hash = [System.BitConverter]::ToString(
    [System.Security.Cryptography.MD5]::Create().ComputeHash(
        [System.Text.Encoding]::UTF8.GetBytes($Password + $Salt)
    )
).Replace("-", "").ToLower()

$Base = "$Server/rest"

$Common = @{
    u = $Username
    t = $Hash
    s = $Salt
    v = "1.16.1"
    c = "Grooove"
    f = "json"
}

$Output = Join-Path $PSScriptRoot "..\docs\api_examples"
$Output = [System.IO.Path]::GetFullPath($Output)

if (-not (Test-Path $Output)) {
    New-Item -ItemType Directory -Force -Path $Output | Out-Null
}

Write-Host ""
Write-Host "========== PING =========="

$Ping = Invoke-Subsonic -Endpoint "ping.view"

if ($Ping."subsonic-response".status -ne "ok") {
    $Ping."subsonic-response".error | Format-List
    exit 1
}

$Ping | ConvertTo-Json -Depth 10 | Out-File -Encoding utf8 (Join-Path $Output "ping.json")

Write-Host "Saved ping.json"

Write-Host ""
Write-Host "========== ALBUMS =========="

$AlbumResponse = Invoke-Subsonic -Endpoint "getAlbumList2.view" -Extra @{
    type   = "alphabeticalByName"
    size   = 50
    offset = 0
}

$AlbumResponse | ConvertTo-Json -Depth 20 | Out-File -Encoding utf8 (Join-Path $Output "albums.json")

$AlbumList = @($AlbumResponse."subsonic-response".albumList2.album)
if ($AlbumList.Count -eq 0) {
    Write-Host "No albums found in library."
    exit 0
}

$Album = $AlbumList[0]

Write-Host "Album:"
Write-Host $Album.name

Write-Host ""
Write-Host "========== SONGS =========="

$AlbumDetails = Invoke-Subsonic -Endpoint "getAlbum.view" -Extra @{ id = $Album.id }

$AlbumDetails | ConvertTo-Json -Depth 20 | Out-File -Encoding utf8 (Join-Path $Output "album.json")

$Songs = @($AlbumDetails."subsonic-response".album.song)
$i = 1
foreach ($Song in $Songs) {
    Write-Host "$i. $($Song.title)"
    $i++
}

$FirstSong = $Songs[0]

$StreamUrl = "$Base/stream.view?" + (Get-SubsonicQueryString -Extra @{ id = $FirstSong.id })
$CoverUrl = "$Base/getCoverArt.view?" + (Get-SubsonicQueryString -Extra @{
    id   = $Album.coverArt
    size = 600
})

$StreamUrl | Out-File -Encoding utf8 (Join-Path $Output "stream.txt")
$CoverUrl | Out-File -Encoding utf8 (Join-Path $Output "coverart.txt")

Write-Host ""
Write-Host "Saved:"
Write-Host "ping.json"
Write-Host "albums.json"
Write-Host "album.json"
Write-Host "stream.txt"
Write-Host "coverart.txt"
