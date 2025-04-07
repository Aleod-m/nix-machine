#!/usr/bin/env bash
focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
curr_ws=$(hyprctl monitors -j | jq '.[0].activeWorkspace.id')
next_ws=$((($curr_ws + 8) % 10 + 1))
hyprctl dispatch -- workspace $next_ws
hyprctl dispatch -- workspace $(($next_ws + 10))
