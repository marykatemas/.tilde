$ErrorActionPreference = "Stop"

$principal = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "DO NOT RUN AS ADMIN!"
}

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

$WingetApps = @(
    "Microsoft.PowerToys"
    "Microsoft.VisualStudioCode"
    "RARLab.WinRAR"
    "RamenSoftware.Windhawk"
    "LocalSend.LocalSend"
    "Git.Git"
    "Anomaly.OpenCode"
    # "glzr-io.glazewm"
    # "Alacritty.Alacritty"
    "Telegram.TelegramDesktop"
    "Discord.Discord"
    "OBSProject.OBSStudio"
    # "Valve.Steam"
    # "RiotGames.LeagueOfLegends.EUW"
    "Parsec.Parsec"
    "Parsec.ParsecVDD"
    "Parsec.ParsecVUD"
    "VB-Audio.Voicemeeter"
    "Happ.Happ"
    "Microsoft.VCRedist.2005.x86"
    "Microsoft.VCRedist.2005.x64"
    "Microsoft.VCRedist.2008.x86"
    "Microsoft.VCRedist.2008.x64"
    "Microsoft.VCRedist.2010.x86"
    "Microsoft.VCRedist.2010.x64"
    "Microsoft.VCRedist.2012.x86"
    "Microsoft.VCRedist.2012.x64"
    "Microsoft.VCRedist.2013.x86"
    "Microsoft.VCRedist.2013.x64"
    "Microsoft.VCRedist.2015+.x86"
    "Microsoft.VCRedist.2015+.x64"
    "Microsoft.DirectX"
)

if ($WingetApps.Count) {
    Write-Host "Installing winget apps: $($WingetApps -join ' ')"
    foreach ($app in $WingetApps) {
        winget install --id $app --exact --accept-source-agreements --accept-package-agreements
    }
    winget upgrade --all --include-unknown --silent --accept-source-agreements --accept-package-agreements
}

$env:PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [Environment]::GetEnvironmentVariable("PATH", "User")

$Personalize = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
Set-ItemProperty $Personalize AppsUseLightTheme -Value 0 -Type DWord
Set-ItemProperty $Personalize SystemUsesLightTheme -Value 0 -Type DWord

$Advanced = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty $Advanced TaskbarLocation -Value 1 -Type DWord
Set-ItemProperty $Advanced HideIcons -Value 1 -Type DWord

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
if (-not (Get-Process explorer -ErrorAction SilentlyContinue)) { Start-Process explorer }

$TildeDir = Join-Path $HOME ".tilde"
if (Test-Path $TildeDir) {
    Move-Item $TildeDir "$TildeDir.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
}
git clone https://github.com/marykatemas/.tilde.git $TildeDir
Push-Location $TildeDir
try {
    # $KEY = Read-Host "Enter absolute path to git-crypt key"
    # git-crypt unlock $KEY
    git submodule update --init --recursive
}
finally {
    Pop-Location
}

foreach ($dir in @("MARYKATEMAS", "Active", "Inactive")) {
    New-Item -ItemType Directory -Path (Join-Path $HOME $dir) -Force | Out-Null
}

& (Join-Path $TildeDir "scripts\symlinks.ps1")
