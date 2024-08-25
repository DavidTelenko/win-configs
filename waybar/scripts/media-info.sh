full_metadata_fmt="{{ title }}\n{{ artist }}\n{{ album }}"
progress_fmt="{{ duration(position) }} / {{ duration(mpris:length) }}"
song_info_fmt="{{ artist }} - {{ title }}"

metadata=$(playerctl metadata -f "$progress_fmt $song_info_fmt")
full_metadata=$(playerctl metadata -f "$full_metadata_fmt")

status_upper="$(playerctl status)"
status="${status_upper,,}"

echo {\"text\": \""$metadata"\", \"alt\": \""$status"\", \"tooltip\": "\"$full_metadata\"", "\"class"\": "\"$status"\"}
