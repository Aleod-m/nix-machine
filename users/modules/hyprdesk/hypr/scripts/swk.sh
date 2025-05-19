#!/usr/bin/env bash

focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
while read -r id; do
    hyprctl dispatch -- focuse_monitor "$id"
    hyprctl dispatch -- workspace $((id * 10 + $1))
done < <(hyprctl monitors -j | jq ".[] | .id")
hyprctl dispatch -- focusmonitor "$focused_monitor"

# hyprctl dispatch -- focusmonitor 0
# hyprctl dispatch -- workspace "$1"
# hyprctl dispatch -- focusmonitor 1
# hyprctl dispatch -- workspace $((10 + $1))
