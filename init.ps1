$curr = pwd
ni -i SymbolicLink -fo $profile -ta $curr/.pwshrc
ni -i SymbolicLink -fo $env:localappdata/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json -ta $curr/.wintermrc
rm -r -fo $env:localappdata/nvim
ni -i Junction $env:localappdata/nvim -ta $curr/.nvim/
