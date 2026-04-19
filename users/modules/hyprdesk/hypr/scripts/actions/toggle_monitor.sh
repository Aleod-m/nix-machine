#!/usr/bin/env bash

#shellcheck disable=1090
source "$ROFI_HELPER"

init() {
	set_opt "prompt" "Select monitor to toggle";
	set_opt "markup-rows" "true";

	local monitors
	local disabled 
	
	monitors=$(hyprctl monitors all -j)
	for monitor in $(echo "$monitors" | jq -r "map(.name).[]"); do
		disabled="$(echo "$monitors" | jq -r "map(select(.name == \"$monitor\")) |first.disabled")";
		if [ "$disabled" = "true" ]; then
			row "$monitor" "display" "<span foreground=\"#FF0000\">$monitor</span>"
		else
			row "$monitor" "display" "<span foreground=\"#00FF00\">$monitor</span>"
		fi
	done
}

on_select() {
	monitors=$(hyprctl monitors all -j)
	disabled="$(echo "$monitors" | jq -r "map(select(.name == \"$1\")) |first.disabled")";
	if [ "$disabled" = "true" ]; then
		hyprctl keyword monitor "$1",enable 1>/dev/null 2>&1;
	else
		hyprctl keyword monitor "$1",disable 1>/dev/null 2>&1;
	fi
}

run_rofi "$@"


