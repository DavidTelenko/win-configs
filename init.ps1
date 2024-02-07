$curr = pwd

ni -i SymbolicLink -fo $profile -ta $curr/pwshrc.ps1
ni -i SymbolicLink -fo $env:appdata/alacritty/alacritty.toml -ta $curr/alacritty.toml

rm -r -fo $env:localappdata/nvim
ni -i Junction $env:localappdata/nvim -ta $curr/nvim/

rm -r -fo $env:appdata/nushell
ni -i Junction $env:appdata/nushell/ -ta $curr/nushell/

cat $curr/winterm.json > ~/scoop/persist/windows-terminal/settings/settings.json
cat $curr/winterm.json > ~/scoop/persist/windows-terminal-preview/settings/settings.json
