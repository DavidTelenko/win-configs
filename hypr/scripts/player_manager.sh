#!/bin/bash

state_file="$HOME/.config/hypr/scripts/data/player_state"

select_source() {
  readarray -t players < <(playerctl -l)
  echo $(($1 % ${#players[@]})) > $state_file
}

next() {
  select_source $(($(cat $state_file) + 1))
}

prev() {
  select_source $(($(cat $state_file) - 1))
}

get() {
  local index=$(cat $state_file)

  readarray -t players < <(playerctl -l)

  if ((index >= ${#players[@]})); then
    echo 0
	return
  fi

  echo ${players[$index]}
}

f_call=$1; shift; $f_call "$@"
