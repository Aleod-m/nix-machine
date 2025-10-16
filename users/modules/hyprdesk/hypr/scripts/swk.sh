#!/usr/bin/env bash

mon=$(hyprctl monitors -j)

# Sanity checks
[[ $(echo "$mon" | jq 'length') -ne 2 ]] && exit 1 

# Store orignaly focused monitor
fmon=$(hyprctl monitors - j | jq 'map(select(.focused)) | first .id')
while read -r mid; do
    # Focus monitor
    hyprctl dispatch -- focusmonitor "$mid"
    # Change workspace of monitor
    hyprctl dispatch -- workspace "$((mid * 10 + $1))"
done < <(echo "$mon" | jq ".[].id")

# Restore orignaly focused monitor
hyprctl dispatch -- focusmonitor "$fmon"
