# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
geometry=`xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="`xdg-user-dir PICTURES`/Screenshots"
file="Screenshot_${time}_${geometry}.png"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
	if [[ -e "$dir/$file" ]]; then
		dunstify -u low --replace=699 "$file saved."
	fi
}

# Copy screenshot to clipboard
copy_shot () {
	cat $dir/$file | wl-copy
}

shot() {
	cd ${dir} && grim -t png $file
	copy_shot
	notify_view
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		dunstify -t 1000 --replace=699 "Taking shot in: $sec"
		sleep 1
	done
}

shot_win () {
	cd ${dir} && grim -t png -o `xdotool getactivewindow` $file
	copy_shot
	notify_view
}

shot_area () {
	cd ${dir} && grim -t png -g "$(slurp)" $file
	copy_shot
	notify_view
}

"$@"
