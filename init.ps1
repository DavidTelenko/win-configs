$curr = pwd

ni -i SymbolicLink -fo $profile -ta $curr/.pwshrc
ni -i SymbolicLink -fo $env:appdata/alacritty/alacritty.toml -ta $curr/.alacritty.toml

rm -r -fo $env:localappdata/nvim
ni -i Junction $env:localappdata/nvim -ta $curr/.nvim/

rm -r -fo $env:appdata/nushell
ni -i Junction $env:appdata/nushell/ -ta $curr/.nushell/
