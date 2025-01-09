# WARNING: This script is not yet tested and therefore is experimental, test it
# first and find all bugs if present

# NOTE: this def is a part of a core.nu module, however we copy it here for
# portability matters
def symlink [
    link_name: path # The name of the symlink
    existing: path  # The existing file
] {
  let link_name = ($link_name | path expand)
  let existing = ($existing | path expand -s)

  print $"(ansi green)($link_name) ==> (ansi blue)($existing)"

  if $nu.os-info.family != 'windows' {
    ln -s $existing $link_name | ignore
    return
  }

  if ($existing | path type) == 'dir' {
    mklink /D $link_name $existing
    return
  }

  mklink $link_name $existing
}

export def main [
  --all = false,
  --pwsh = false,
  --nvim = false,
  --helix = false,
  --lazygit = false,
  --winterm = false,
  --rio = false,
  --wezterm = false,
  --nushell = false,
  --alacritty = false,
  --broot = false,
  --mpv = false,
  --ttyper = false,
  --vencord = false,
  --musikcube = false,
  --keymapper = false,
  --kanata = false,
] {
  let pwsh = $all or $pwsh
  let nvim = $all or $nvim
  let helix = $all or $helix
  let lazygit = $all or $lazygit
  let winterm = $all or $winterm
  let rio = $all or $rio
  let wezterm = $all or $wezterm
  let nushell = $all or $nushell
  let alacritty = $all or $alacritty
  let broot = $all or $broot
  let mpv = $all or $mpv
  let ttyper = $all or $ttyper
  let vencord = $all or $vencord
  let musikcube = $all or $musikcube
  let keymapper = $all or $keymapper
  let kanata = $all or $kanata

  let curr = pwd
  let scoop = $"($env.userprofile)/scoop/persist"

  if ($pwsh) {
    let pwsh_profile = powershell "$profile"
    symlink $pwsh_profile $"($curr)/powershell/profile.ps1"
  }
  if ($alacritty) {
    symlink $"($env.appdata)/alacritty" $"($curr)/alacritty"
  }
  if ($rio) {
    symlink $"($env.localappdata)/rio" $"($curr)/rio"
  }
  if ($nvim) {
    symlink $"($env.localappdata)/nvim" $"($curr)/nvim"
  }
  if ($lazygit) {
    symlink $"($env.localappdata)/lazygit" $"($curr)/lazygit"
  }
  if ($helix) {
    symlink $"($env.appdata)/helix" $"($curr)/helix"
  }
  if ($nushell) {
    symlink $"($env.appdata)/nushell" $"($curr)/nushell"
  }
  if ($wezterm) {
    symlink $"($env.homepath)/.config/wezterm" $"($curr)/wezterm"
  }

  if ($broot) {
    symlink $"($env.appdata)/dystroy/broot" $"($curr)/broot"
  }
  if ($mpv) {
    symlink $"($scoop)/mpv/portable_config" $"($curr)/mpv"
  }
  if ($ttyper) {
    symlink $"($env.appdata)/ttyper" $"($curr)/ttyper"
  }
  if ($vencord) {
    symlink $"($env.appdata)/Vencord" $"($curr)/vencord"
  }
  if ($musikcube) {
    symlink $"($env.appdata)/musikcube" $"($curr)/musikcube"
  }
  if ($keymapper) {
    symlink $"($env.appdata)/keymapper" $"($curr)/keymapper"
  }
  if ($kanata) {
    symlink $"($env.appdata)/kanata" $"($curr)/kanata"
  }

  # NOTE: you don't need to turn off winterm in order to run this option, it
  # will hot reload as of latest version
  if ($winterm) {
    open $"($curr)/windows-terminal/winterm.json"
    | save $"($scoop)/windows-terminal-preview/settings/settings.json"
  }
}
