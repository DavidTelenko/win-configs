#!/bin/bash

link() {
  echo "link $HOME/.config/$1 -> $(pwd)/$1"
  ln -sfn "$(pwd)/$1" "$HOME/.config/$1"
}

link cmus
link dunst
link ghostty
link hypr
link mpv
link nushell
link nvim
link rofi
link ttyper
link waybar
