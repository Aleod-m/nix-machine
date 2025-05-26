#!/usr/bin/env bash

focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
while read -r id; do
    echo "focus $id"
    hyprctl dispatch -- focusmonitor "$id"
    echo "change $((id * 10 + $1))"
    hyprctl dispatch -- workspace "$((id * 10 + $1))"
done < <(hyprctl monitors -j | jq ".[] | .id")
echo "restore focus"
hyprctl dispatch -- focusmonitor "$focused_monitor"
