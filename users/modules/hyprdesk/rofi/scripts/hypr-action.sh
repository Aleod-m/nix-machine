#!/usr/bin/env bash
source ./helper.sh

# Action palette for hypr. Runs the selected script in 
# $XDG_CONFIG_HOME/hypr/scripts/actions

HYPRDESC_ACTION_DIR="$HOME/.config/hypr/scripts/actions"


init () {
    set_opt "prompt" "Select action";

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
    bash "$HYPRDESC_ACTION_DIR/${script}.sh" 1>/dev/null 2>&1;
}

run_rofi
