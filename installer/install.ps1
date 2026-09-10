param(
    [Parameter(Mandatory = $true)][string]$GameDirectory,
    [Parameter(Mandatory = $true)][string]$PayloadDirectory
)

$ErrorActionPreference = 'Stop'
$pakDirectory = Join-Path $GameDirectory 'ASSAULT_SPY\Content\Paks'
$manifest = Get-Content -LiteralPath (Join-Path $PayloadDirectory 'manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json

function Get-Sha256Hex([string]$Path) {
    $stream = [IO.File]::OpenRead($Path)
    $algorithm = [Security.Cryptography.SHA256]::Create()
    try {
        return ([BitConverter]::ToString($algorithm.ComputeHash($stream))).Replace('-', '')
    } finally {
        $algorithm.Dispose()
        $stream.Dispose()
    }
}

foreach ($file in $manifest.files) {
    $source = Join-Path $PayloadDirectory $file.name
    if (-not (Test-Path -LiteralPath $source)) {
        throw "누락된 패치 파일: $($file.name)"
    }
    if ((Get-Sha256Hex $source) -ne $file.sha256) {
        throw "패치 파일 손상: $($file.name)"
    }
}

$backup = Join-Path (Join-Path $GameDirectory 'KoreanPatch_Backup') ('BAT_' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Path $backup -Force | Out-Null
foreach ($file in $manifest.files) {
    $destination = Join-Path $pakDirectory $file.name
    if (Test-Path -LiteralPath $destination) {
        Copy-Item -LiteralPath $destination -Destination (Join-Path $backup $file.name) -Force
    }
}

try {
    foreach ($file in $manifest.files) {
        $source = Join-Path $PayloadDirectory $file.name
        $destination = Join-Path $pakDirectory $file.name
        Copy-Item -LiteralPath $source -Destination $destination -Force
        if ((Get-Sha256Hex $destination) -ne $file.sha256) {
            throw "설치 검증 실패: $($file.name)"
        }
        $installed = Get-Item -LiteralPath $destination -Force
        $installed.Attributes = $installed.Attributes -bor [IO.FileAttributes]::Hidden
    }
} catch {
    foreach ($file in $manifest.files) {
        $saved = Join-Path $backup $file.name
        $destination = Join-Path $pakDirectory $file.name
        if (Test-Path -LiteralPath $saved) {
            Copy-Item -LiteralPath $saved -Destination $destination -Force
        } elseif (Test-Path -LiteralPath $destination) {
            Remove-Item -LiteralPath $destination -Force
        }
    }
    throw
}

[pscustomobject]@{
    Patch = $manifest.patchName
    InstalledAt = (Get-Date).ToString('o')
    GameDirectory = $GameDirectory
    BackupDirectory = $backup
    Files = $manifest.files
} | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $backup 'install_log.json') -Encoding UTF8

Write-Host "백업 위치: $backup"
