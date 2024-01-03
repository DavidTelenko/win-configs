$curr = pwd

ni -i SymbolicLink -fo $profile -ta $curr/.pwshrc

rm -r -fo $env:localappdata/nvim
ni -i Junction $env:localappdata/nvim -ta $curr/.nvim/

rm -r -fo $env:appdata/nushell
ni -i Junction $env:appdata/nushell/ -ta $curr/.nushell/
