param (
    [Alias("PowerShell")]
    [Switch] $Pwsh = $false,

    [Alias("Neovim")]
    [Switch] $Nvim = $false,

    [Alias("WindowsTerminal")]
    [Switch] $Winterm = $false,

    [Switch] $Alacritty = $false,
    [Switch] $Nushell = $false
)

$curr = pwd
$scoop = "$env:userprofile/scoop/persist"

function Link {
    param (
        [String] $Target,
        [String] $Existing
    )
    if (Test-Path -Path $Target -PathType Container) {
        rm -r -fo $Target
        echo "Removed: $Target"
        ni -i Junction -fo $Target -ta $Existing
        echo "Linked: $Target -> $Existing"
    }
    elseif(Test-Path -Path $Target -PathType Leaf) {
        rm -fo $Target
        echo "Removed: $Target"
        ni -i SymbolicLink -fo $Target -ta $Existing
        echo "Linked: $Target -> $Existing"
    }
}

function CopyContent {
    param (
        [String] $Target,
        [String] $Existing
    )
    if (Test-Path -Path $Target -PathType Leaf) {
        cat $Existing > $Target
        echo "Copied: $Existing > $Target"
    }
}

if ($Pwsh) {
    Link -t $profile -e $curr/pwshrc.ps1
}
if ($Alacritty) {
    Link -t $env:appdata/alacritty/alacritty.toml -e $curr/alacritty.toml
}
if ($Nvim) {
    Link -t $env:localappdata/nvim -e $curr/nvim
}
if ($Nushell) {
    Link -t $env:appdata/nushell -e $curr/nushell
}

if ($Winterm) {
    CopyContent -t $scoop/windows-terminal/settings/settings.json -e $curr/winterm.json
    CopyContent -t $scoop/windows-terminal-preview/settings/settings.json  -e $curr/winterm.json
}
