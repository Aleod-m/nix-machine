#!/usr/bin/env bash

monitor=$(hyprctl activewindow -j | jq '.monitor')
targetworkspace=$((monitor * 10 + $1))
hyprctl dispatch -- movetoworkspacesilent $targetworkspace
