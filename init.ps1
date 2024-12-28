param (
    [Switch] $All = $false,
    # Dev
    [Alias("PowerShell")]
    [Switch] $Pwsh = $false,
    [Alias("Neovim")]
    [Switch] $Nvim = $false,
    [Switch] $Helix = $false,
    [Switch] $Lazygit = $false,
    [Alias("WindowsTerminal")]
    [Switch] $Winterm = $false,
    [Switch] $Rio = $false,
    [Switch] $Wezterm = $false,
    [Switch] $Nushell = $false,
    # Apps
    [Switch] $Alacritty = $false,
    [Switch] $Broot = $false,
    [Switch] $Mpv = $false,
    [Switch] $Ttyper = $false,
    [Switch] $Vencord = $false,
    [Switch] $Musikcube = $false,
    [Switch] $Keymapper = $false,
    [Switch] $Kanata = $false
)

$Pwsh = $All -or $Pwsh
$Nvim = $All -or $Nvim
$Helix = $All -or $Helix
$Lazygit = $All -or $Lazygit
$Winterm = $All -or $Winterm
$Rio = $All -or $Rio
$Wezterm = $All -or $Wezterm
$Nushell = $All -or $Nushell
$Alacritty = $All -or $Alacritty
$Broot = $All -or $Broot
$Mpv = $All -or $Mpv
$Ttyper = $All -or $Ttyper
$Vencord = $All -or $Vencord
$Musikcube = $All -or $Musikcube
$Keymapper = $All -or $Keymapper
$Kanata = $All -or $Kanata

$curr = pwd
$scoop = "$env:userprofile/scoop/persist"

function Link {
    param (
        [String] $Target,
        [String] $Existing
    )
    if (Test-Path -Path $Existing -PathType Container) {
        rm -r -fo $Target
        ni -i Junction -fo $Target -ta $Existing
        echo "Linked: $Target -> $Existing"
    }
    elseif(Test-Path -Path $Existing -PathType Leaf) {
        rm -fo $Target
        ni -i SymbolicLink -fo $Target -ta $Existing
        echo "Linked: $Target -> $Existing"
    }
}

function CopyContent {
    param (
        [String] $Existing,
        [String] $Target
    )
    if (Test-Path -Path $Target -PathType Leaf) {
        $RawFile = Get-Content -Raw $Existing
        $Utf8Encoded = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllLines($Target, $RawFile, $Utf8Encoded)
        echo "Copied: $Existing > $Target"
    }
}

if ($Pwsh) {
    Link -t $profile -e $curr/powershell/profile.ps1
}
if ($Alacritty) {
    Link -t $env:appdata/alacritty -e $curr/alacritty
}
if ($Rio) {
    Link -t $env:localappdata/rio -e $curr/rio
}
if ($Nvim) {
    Link -t $env:localappdata/nvim -e $curr/nvim
}
if ($Lazygit) {
    Link -t $env:localappdata/lazygit -e $curr/lazygit
}
if ($Helix) {
    Link -t $env:appdata/helix -e $curr/helix
}
if ($Nushell) {
    Link -t $env:appdata/nushell -e $curr/nushell
}
if ($Wezterm) {
    Link -t $env:homepath/.config/wezterm -e $curr/wezterm
}

if ($Broot) {
    Link -t $env:appdata/dystroy/broot -e $curr/broot
}
if ($Mpv) {
    Link -t $scoop/mpv/portable_config -e $curr/mpv
}
if ($Ttyper) {
    Link -t $env:appdata/ttyper -e $curr/ttyper
}
if ($Vencord) {
    Link -t $env:appdata/Vencord -e $curr/vencord
}
if ($Musikcube) {
    Link -t $env:appdata/musikcube -e $curr/musikcube
}
if ($Keymapper) {
    Link -t $env:appdata/keymapper -e $curr/keymapper
}
if ($Kanata) {
    Link -t $env:appdata/kanata -e $curr/kanata
}

# NOTE: you don't need to turn off winterm in order to run this option, it will hot reload as of latest version
if ($Winterm) {
    CopyContent -e $curr/windows-terminal/winterm.json -t $scoop/windows-terminal-preview/settings/settings.json
}
