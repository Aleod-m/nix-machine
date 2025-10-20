#!/usr/bin/env bash
focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
curr_ws=$(hyprctl monitors -j | jq '.[0].activeWorkspace.id')
next_ws=$(((curr_ws + 8) % 10 + 1))

while read -r id; do
    hyprctl dispatch -- focusmonitor "$id"
    hyprctl dispatch -- workspace $((id * 10 + next_ws))
done < <(hyprctl monitors -j | jq ".[] | .id")
hyprctl dispatch -- focusmonitor "$focused_monitor"
