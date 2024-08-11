#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Battery

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Battery Info
battery="`acpi -b | cut -d',' -f1 | cut -d':' -f1`"
status="`acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '`"
percentage="`acpi -b | cut -d',' -f2 | tr -d ' ',\%`"
time="`acpi -b | cut -d',' -f3`"

if [[ -z "$time" ]]; then
	time=' Fully Charged'
fi

# Theme Elements
prompt="$status"
mesg="${battery}: ${percentage}%,${time}"

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='4'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='4'
	win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='4'
	win_width='500px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='4'
	list_row='1'
	win_width='550px'
fi

# Charging Status
active=""
urgent=""
if [[ $status = *"Charging"* ]]; then
    active="-a 1"
    ICON_CHRG=""
elif [[ $status = *"Full"* ]]; then
    active="-u 1"
    ICON_CHRG=""
else
    urgent="-u 1"
    ICON_CHRG=""
fi

# Discharging
batteries="󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹"
index=$(($percentage / 10 - 1))
ICON_DISCHRG="${batteries:$index:1}"

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Remaining ${percentage}%"
	option_2=" $status"
	option_3=" Power Manager"
	option_4=" Diagnose"
else
	option_1="$ICON_DISCHRG"
	option_2="$ICON_CHRG"
	option_3=""
	option_4=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str "textbox-prompt-colon {str: \"$ICON_DISCHRG\";}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}


# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		dunstify --replace=699 -u low " Remaining : ${percentage}%"
        ;;
    $option_2)
		dunstify --replace=699 -u low "$ICON_CHRG Status : $status"
        ;;
    $option_3)
		xfce4-power-manager-settings
        ;;
    $option_4)
		${polkit_cmd} alacritty -e powertop
        ;;
esac
