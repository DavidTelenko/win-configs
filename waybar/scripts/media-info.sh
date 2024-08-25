full_metadata_fmt="{{ title }}\n{{ artist }}\n{{ album }}"
progress_fmt="{{ duration(position) }} / {{ duration(mpris:length) }}"
song_info_fmt="{{ artist }} - {{ title }}"

metadata=$(playerctl metadata -f "$progress_fmt $song_info_fmt")
full_metadata=$(playerctl metadata -f "$full_metadata_fmt")

status_upper="$(playerctl status)"
status="${status_upper,,}"

metadata_esc=$(echo "$metadata" | sed 's/"/\\"/g')
full_metadata_esc=$(echo "$full_metadata" | sed 's/"/\\"/g')

echo {\"text\": \""$metadata_esc"\", \"alt\": \""$status"\", \"tooltip\": "\"$full_metadata_esc\"", "\"class"\": "\"$status"\"}
