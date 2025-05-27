#!/usr/bin/env bash

# Store orignaly focused monitor
focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
while read -r mid; do
    # Focus monitor
    hyprctl dispatch -- focusmonitor "$mid"
    # Change workspace of monitor
    hyprctl dispatch -- workspace "$((mid * 10 + $1))"
done < <(hyprctl monitors -j | jq ".[].id")
# Restore orignaly focused monitor
hyprctl dispatch -- focusmonitor "$focused_monitor"
