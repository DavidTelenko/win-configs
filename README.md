# Win Configs

This repo aims to create single simple source of all necessary system
configuration file for all tools I need.

It is constantly updating and is not a place familiar with stability.

The future goal of this repo is to be reproducible on different operating
systems. However for now this is not finished nor tested which is why sadly it
only supports MS Windows (hence the name).

# What's inside

The main guts of this repo mostly contains configs for `nushell` and `neovim`.
As of today windows does not support most of the frequently used shells and I
am not really a huge fun of WSL so I decided to use `nushell`. The downside of
this approach is that `nushell` does not come with fresh windows system (and we
assume this repo is being installed on a fresh system in the first place) so
writing a cross-platform `nu` bootstrap script is not an option. Thus this repo
only contains the `ps1` bootstrap and init scripts which are simple
initialization scripts for downloading and installing all the necessary
packages as well as creating all the necessary symlinks to all folders in this
directory.

The list of packages to be installed can be found in a scoopfile.json

All configured tools by this repo:
- Neovim
- Helix (a backup plan editor :D)
- Nushell
- Windows Terminal
- Alacritty
- Ttyper
- Power Toys (cannot be automatically configured you need to import config in
  the settings of the app)
- Oh My Posh
- PowerShell
- Spotify (Spicetify + SpotX)
- Vimium browser extension (that's just a simple little piece of backup)

# Installation

To bootstrap the system run the `bootstrap.ps1` script followed by `init.ps1`
script with names of tools you wish to link.

It's apparent that's a "chicken and an egg" problem may occur in the case of
fresh system because the scoop is not yet installed however we need git in
order to clone repo and run the bootstrap script.

The simple solution is to first just download the script manually (or via web
request) then run it and it will do all dirty typing for us (*The Chicken
method*).

This method can be run like this

```powershell
iwr -useb https://raw.githubusercontent.com/DavidTelenko/win-configs/master/bootstrap.ps1 | iex
cd ~/.configs
init.ps1 Nvim Winterm Pwsh
```

Another solution is to manually download git, clone repo and run bootstrap with
an `-Egg` parameter this will effectively do the same, **however** you will be
left with two git instances on your pc - yours and scoop's (*The Egg method*).

The names of the parameters for the `init.ps1` is the following:

  - Pwsh        or PowerShell
  - Nvim        or Neovim
  - Helix
  - Ttyper
  - Winterm     or WindowsTerminal
  - Alacritty
  - Nushell

# Notes

  - **Power Toys** - cannot be adequately configured using symlinks to its config
    files so we just use their own manual system of backing up stuff

  - **Windows Terminal** - its better not to sym or hard link config file to the
    file in the config directory, after all its the terminal emulator and some
    stuff tends to diverge in different computers, so this repo only contains
    most general settings of my liking

  - **Vimium** - it does not support any type of automated backup mechanic (as
    far as I know) so it's the same as with powertoys - manual import.
