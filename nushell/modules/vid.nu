# this is little ffmgeg wrapper mostly for recalling actual ffmpeg commands

export def remove-sound [in: path, out: path] {
  ffmpeg -i $in -c copy -an $out
}

export def speed-up [in: path, out: path, factor: number] {
  ffmpeg -i $in -filter:v "setpts=0.25*PTS" $out
}

export def cut [in: path, out: path, start: string, end: string] {
  ffmpeg -i $in -ss $start -to $end -c copy $out
}
