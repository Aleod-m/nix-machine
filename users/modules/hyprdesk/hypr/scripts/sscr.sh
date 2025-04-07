#!/usr/bin/env bash
monitor=$(hyprctl activewindow -j | jq '.monitor')
monitor=$(((monitor + 1) % 2))
hyprctl dispatch -- focusmonitor $monitor
