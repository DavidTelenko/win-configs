#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Volume

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Volume Info
mixer="`amixer info Master | grep 'Mixer name' | cut -d':' -f2 | tr -d \',' '`"
speaker="`amixer get Master | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]'`"
mic="`amixer get Capture | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]'`"

active=""
urgent=""

# Speaker Info
amixer get Master | grep '\[on\]' &>/dev/null
if [[ "$?" == 0 ]]; then
	active="-a 1"
	stext='Unmute'
	sicon=''
else
	urgent="-u 1"
	stext='Mute'
	sicon=''
fi

# Microphone Info
amixer get Capture | grep '\[on\]' &>/dev/null
if [[ "$?" == 0 ]]; then
    [ -n "$active" ] && active+=",3" || active="-a 3"
	mtext='Unmute'
	micon=''
else
    [ -n "$urgent" ] && urgent+=",3" || urgent="-u 3"
	mtext='Mute'
	micon=''
fi

# Theme Elements
prompt="S:$stext, M:$mtext"
mesg="$mixer - Speaker: $speaker, Mic: $mic"

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='5'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='5'
	win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='5'
	win_width='520px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='5'
	list_row='1'
	win_width='670px'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Decrese"
	option_2="$sicon $stext"
	option_3=" Increase"
	option_4="$micon $mtext"
	option_5=" Settings"
else
	option_1=""
	option_2="$sicon"
	option_3=""
	option_4="$micon"
	option_5=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		amixer -Mq set Master,0 5%- unmute
        ;;
    $option_2)
		amixer set Master toggle
        ;;
    $option_3)
		amixer -Mq set Master,0 5%+ unmute
        ;;
    $option_4)
		amixer set Capture toggle
        ;;
    $option_5)
		pavucontrol
        ;;
esac

