dir="$HOME/.config/rofi/launchers/type-2"
theme='style-1'

## Run
cliphist list \
| rofi \
    -dmenu \
    -theme ${dir}/${theme}.rasi \
| cliphist decode \
| wl-copy
