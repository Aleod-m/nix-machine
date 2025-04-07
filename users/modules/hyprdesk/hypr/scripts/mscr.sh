#!/usr/bin/env bash
focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
monitor=$((($focused_monitor + 1) % 2))
other_ws=$(hyprctl monitors -j | jq "map(select(.id == $monitor)).[0].activeWorkspace.id")
hyprctl dispatch -- movetoworkspace $other_ws
