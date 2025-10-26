#!/usr/bin/env bash

# Should all of this be on per-package basis?

rpm-fusion() {
  echo "https://download1.rpmfusion.org/$1/fedora/rpmfusion-$1-release-$(rpm -E %fedora).noarch.rpm"
}

dnf install $(rpm-fusion free)
dnf install $(rpm-fusion nonfree)

dnf copr enable agriffis/neovim-nightly
dnf copr enable alternateved/keyd
dnf copr enable rivenirvana/ghostty
dnf copr enable sneexy/zen-browser
dnf copr enable solopasha/hyprland

dnf install acpi
dnf install aria2c
dnf install cmus
dnf install discord
dnf install dunst
dnf install gh
dnf install ghostty
dnf install git
dnf install go
dnf install grim
dnf install hypridle
dnf install hyprland
dnf install hyprlock
dnf install hyprsunset
dnf install keyd
dnf install mpv
dnf install nodejs
dnf install oh-my-posh
dnf install pavucontrol
dnf install playerctl
dnf install rustup
dnf install slurp
dnf install steam
dnf install swww
dnf install telegram-desktop
dnf install tmux
dnf install unar
dnf install waybar
dnf install wf-recorder
dnf install wl-paste
dnf install zen-browser

rustup update

cargo install nu
cargo install vivid
cargo install zoxide
cargo install hyprland-per-window-layout

go install github.com/aandrew-me/tgpt/v2@latest
