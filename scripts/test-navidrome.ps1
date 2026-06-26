# ============================================
# Groooove - Navidrome API Smoke Test
# ============================================
# Copy scripts/config.example.ps1 to scripts/config.local.ps1 before running.

$configPath = Join-Path $PSScriptRoot "config.local.ps1"
if (-not (Test-Path $configPath)) {
    Write-Error "Missing config.local.ps1 - copy config.example.ps1 to config.local.ps1 and set your password."
    exit 1
}

. $configPath

# --------------------------------------------
# Generate authentication token
# --------------------------------------------

$Salt = -join ((97..122) | Get-Random -Count 8 | ForEach-Object { [char]$_ })

$MD5 = [System.Security.Cryptography.MD5]::Create()
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($Password + $Salt)
$Token = ($MD5.ComputeHash($Bytes) | ForEach-Object { $_.ToString("x2") }) -join ""

$Common = @{
    u = $Username
    t = $Token
    s = $Salt
    v = "1.16.1"
    c = "Groooove"
    f = "json"
}

# ============================================
# PING
# ============================================

Write-Host ""
Write-Host "========== PING =========="

$Ping = Invoke-RestMethod `
    -Uri "$Server/rest/ping.view" `
    -Method Get `
    -Body $Common

$Ping.'subsonic-response'

# ============================================
# GET ALBUMS
# ============================================

Write-Host ""
Write-Host "========== ALBUMS =========="

$Albums = Invoke-RestMethod `
    -Uri "$Server/rest/getAlbumList2.view" `
    -Method Get `
    -Body ($Common + @{
        type = "alphabeticalByName"
        size = 50
        offset = 0
    })

$Album = $Albums.'subsonic-response'.albumList2.album | Select-Object -First 1

Write-Host ""
Write-Host "Album:"
Write-Host $Album.name
Write-Host ""

# ============================================
# GET SONGS
# ============================================

Write-Host "========== SONGS =========="

$AlbumInfo = Invoke-RestMethod `
    -Uri "$Server/rest/getAlbum.view" `
    -Method Get `
    -Body ($Common + @{
        id = $Album.id
    })

foreach ($Song in $AlbumInfo.'subsonic-response'.album.song)
{
    Write-Host "$($Song.track). $($Song.title)"
}