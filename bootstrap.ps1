# Simple scoop based bootstrap scrip for a fresh system

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex "& {$(irm get.scoop.sh)} -RunAsAdmin"

$buckets = @(
    "extras",
    "games",
    "versions",
)

$packages = @(
    "7zip",
    "aimp",
    "ascii-image-converter",
    "autohotkey",
    "clangd",
    "cmake",
    "coreutils",
    "dependencies",
    "eza",
    "ffmpeg",
    "fzf",
    "gcc",
    "git",
    "heroic-games-launcher",
    "innounp",
    "make",
    "mingw-winlibs-llvm",
    "mpc-hc-fork",
    "neovim",
    "ninja",
    "nodejs",
    "nu",
    "obs-studio",
    "obsidian",
    "oh-my-posh",
    "paint.net",
    "premake",
    "pueue",
    "python",
    "qbittorrent",
    "ripgrep",
    "steam",
    "telegram",
    "windows-terminal",
    "winfetch",
    "wiztree",
    "zig",
    "zoxide",
)

foreach ($bucket in $buckets) {
    scoop buckets add $bucket
}

foreach ($package in $packages) {
    scoop install $package
}

# separate spicetify install
iex "& { $(iwr -useb 'https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1') } -confirm_uninstall_ms_spoti -confirm_spoti_recomended_over -podcasts_off -block_update_on -start_spoti -new_theme -adsections_off -lyrics_stat spotify"
iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.ps1 | iex
iwr -useb https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.ps1 | iex
