#!/usr/bin/env bash

nb_monitors=$(hyprctl monitors -j | jq length)
focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
monitor=$(((focused_monitor + 1) % nb_monitors))
other_ws=$(hyprctl monitors -j | jq "map(select(.id == $monitor)).[0].activeWorkspace.id")
hyprctl dispatch -- movetoworkspace "$other_ws"
