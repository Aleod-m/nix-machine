#!/usr/bin/env bash
# Action palette for hypr. Runs the selected script in 
# $XDG_CONFIG_HOME/hypr/scripts/actions

#shellcheck disable=1090
source "$ROFI_HELPER"
HYPRDESC_ACTION_DIR="$HOME/.config/hypr/scripts/actions"


init () {
    set_opt "prompt" "Select action";

    local actions;
	actions=$(ls "$HYPRDESC_ACTION_DIR");

    for action in $actions; do
        if [ ! -f "$HYPRDESC_ACTION_DIR/$action" ]; then
            continue;
        fi
        action="${action%.sh}"
        row "${action//_/ }"
    done
}

on_select () {
    local script="${1// /_}"
	# Test if action is a simple script or if it has a sub menu.
	if grep "run_rofi" "$HYPRDESC_ACTION_DIR/${script}.sh" 1>/dev/null 2>&1; then
		coproc rofi -show submenu -modes "submenu:$HYPRDESC_ACTION_DIR/${script}.sh"
	else 
    	coproc bash "$HYPRDESC_ACTION_DIR/${script}.sh";
	fi
}

run_rofi "$@"
