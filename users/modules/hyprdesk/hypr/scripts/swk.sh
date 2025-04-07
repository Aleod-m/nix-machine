#!/usr/bin/env bash

focused_monitor=$(hyprctl activewindow -j | jq '.monitor')
hyprctl dispatch -- focusmonitor 0
hyprctl dispatch -- workspace $1
hyprctl dispatch -- focusmonitor 1
hyprctl dispatch -- workspace $((10 + $1))
hyprctl dispatch -- focusmonitor $focused_monitor 
