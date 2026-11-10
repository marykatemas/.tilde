$ErrorActionPreference = "Stop"

function New-Symlink {
    param([string]$Source, [string]$Target)
    if (-not (Test-Path -LiteralPath $Source)) {
        Write-Host "  [skip] $Source"
        return
    }
    $Source = (Resolve-Path -LiteralPath $Source).Path
    $item = Get-Item -LiteralPath $Target -Force -ErrorAction SilentlyContinue
    if ($item.Target -eq $Source) {
        return
    }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Target) | Out-Null
    if ($item) {
        if ($item.LinkType) {
            Remove-Item -LiteralPath $Target -Force
        }
        else {
            $backup = "$Target.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            Write-Host "  [backup] $Target -> $backup"
            Move-Item -LiteralPath $Target -Destination $backup
        }
    }
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
    Write-Host "  [symlink] $Source -> $Target"
}

New-Symlink (Join-Path $HOME ".tilde\Wallpapers") (Join-Path $HOME "Wallpapers")
